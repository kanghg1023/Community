package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.daos.BoardDao;
import com.daos.ListDao;
import com.daos.UserDao;
import com.dtos.BoardDto;
import com.dtos.ListDto;
import com.dtos.UserDto;


@WebServlet("/LoginController.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String command = request.getParameter("command");
		
		UserDao dao = new UserDao();
		if(command.equals("index")){
			session.removeAttribute("readcount");//조회수세션삭제
			session.removeAttribute("pNum");//페이지세션삭제
			ListDao listdao = new ListDao();
			List<ListDto> blist = listdao.listlist();
			BoardDao boarddao = new BoardDao();
			List<BoardDto> bestlist = boarddao.bestList();
			
			request.setAttribute("blist", blist);
			request.setAttribute("bestlist", bestlist);
			dispatch("main.jsp", request, response);
		}else if(command.equals("regist")){
			response.sendRedirect("regist.jsp");
		}else if(command.equals("insertuser")){ //회원가입
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nick = request.getParameter("nick");
			String phone = request.getParameter("phone");
			
			boolean isS = dao.insertUser(new UserDto(email,password,nick,phone,null,null));
			
			if(isS){
				jsForward("LoginController.do?command=index", "회원가입을 축하합니다.!!!", response);
			}else{
				request.setAttribute("msg", "회원가입 실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("login")){
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			UserDto ldto = dao.getLogin(email,password);
			if(ldto == null || ldto.getEmail()==null){
				request.setAttribute("msg", "아이디나 패스워드를 확인하세요");
				dispatch("LoginController.do?command=index", request, response);
			}else{
				if(ldto.getEnabled().equals("N")){
					request.setAttribute("msg", "아이디나 패스워드를 확인하세요");
					dispatch("LoginController.do?command=index", request, response);
				}else{
					session.setAttribute("ldto", ldto); //세션삽입
					session.setMaxInactiveInterval(10*60*1000);//10분간 요청이 없으면 세션을 삭제
					
					response.sendRedirect("LoginController.do?command=index");
				}
			}
		}else if(command.equals("logout")){
			session.invalidate(); //세션지우기
			response.sendRedirect("LoginController.do?command=index");
		}else if(command.equals("emailChk")){
			String email = request.getParameter("email");
			boolean isS = dao.emailChk(email);
			PrintWriter pw = response.getWriter();
			pw.print(isS);
		}else if(command.equals("nickChk")){
			String nick = request.getParameter("nick");
			boolean isS = dao.nickChk(nick);
			PrintWriter pw = response.getWriter();
			pw.print(isS);
		}else if(command.equals("alluserstatus")){
			List<UserDto> list = dao.getAllUserStatus();
			request.setAttribute("list", list);
			dispatch("userlist_status.jsp", request, response);
		}else if(command.equals("alluserlist")){
			List<UserDto> list = dao.getAllUserList();
			request.setAttribute("list", list);
			dispatch("userlist.jsp", request, response);
		}else if(command.equals("authchange")){
			String email = request.getParameter("email");
			String role = request.getParameter("role");
			boolean isS = dao.authchange(email, role);
			if(isS){
				jsForward("LoginController.do?command=alluserlist","회원등급을 수정했습니다.",response);
			}else{
				request.setAttribute("msg", "회원등급 변경실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("useroutfrom")){
			String email = request.getParameter("email");
			UserDto dto = dao.getInfo(email);
			request.setAttribute("dto", dto);
			dispatch("useroutfrom.jsp", request, response);
		}else if(command.equals("userout")){
			String email = request.getParameter("email");
			boolean isS = dao.withdraw(email);
			if(isS){
				jsForward("LoginController.do?command=alluserlist","강제 탈퇴되었습니다.",response);
			}else{
				request.setAttribute("msg", "강제 탈퇴실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("userinfo")){
			response.sendRedirect("user_info.jsp");
		}else if(command.equals("userUpdate")){
			response.sendRedirect("userupdate.jsp");
		}else if(command.equals("update")){
			String email = request.getParameter("email");
			String nick = request.getParameter("nick");
			String phone = request.getParameter("phone");
			boolean isS = dao.userUpdate(new UserDto(email,nick,phone));
			if(isS){
				UserDto ldto = dao.getInfo(email);
				session.setAttribute("ldto", ldto); //세션 재삽입
				jsForward("LoginController.do?command=userinfo","회원정보을 수정했습니다.",response);
			}else{
				request.setAttribute("msg", "회원정보 수정실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("withdraw")){
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			boolean isS = dao.withdraw(ldto.getEmail());
			if(isS){
				jsForward("LoginController.do?command=logout","탈퇴하였습니다.",response);
			}else{
				request.setAttribute("msg", "회원 탈퇴실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("boardlist")){
			dispatch("AnsController.do?command=boardlist", request, response);
		}
		
	}

	public void jsForward(String url, String msg, HttpServletResponse response) throws IOException {
		PrintWriter pw = response.getWriter();
		String str = "<script type='text/javascript'>"
				+"alert('"+msg+"');"
				+"location.href = '"+url+"';"
				+"</script>";
		pw.print(str);
	}
	
	public void dispatch(String url, HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	
}
