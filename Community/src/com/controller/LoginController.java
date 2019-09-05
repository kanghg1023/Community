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

import com.daos.UserDao;
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
		
		if(command.equals("regist")){
			response.sendRedirect("regist.jsp");
		}else if(command.equals("insertuser")){ //회원가입
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nick = request.getParameter("nick");
			String phone = request.getParameter("phone");
			
			boolean isS = dao.insertUser(new UserDto(email,password,nick,phone,null,null));
			
			if(isS){
				jsForward("index.jsp", "회원가입을 축하합니다.!!!", response);
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
				dispatch("error.jsp", request, response);
			}else{
				if(ldto.getEnabled().equals("N")){
					request.setAttribute("msg", "탈퇴한 회원입니다");
					dispatch("error.jsp", request, response);
				}else{
					session.setAttribute("ldto", ldto); //세션삽입
					session.setMaxInactiveInterval(10*60*1000);//10분간 요청이 없으면 세션을 삭제
					
					response.sendRedirect("index.jsp");
				}
			}
		}else if(command.equals("logout")){
			session.invalidate(); //세션지우기
			response.sendRedirect("index.jsp");
		}else if(command.equals("emailChk")){
			String rid = request.getParameter("rid");
			UserDto dto = dao.emailChk(rid);
			request.setAttribute("dto", dto);
			dispatch("emailchkform.jsp", request, response); //여기부터
		}
//			else if(command.equals("alluserstatus")){
//			List<UserDto> list = dao.getAllUserStatus();
//			request.setAttribute("list", list);
//			dispatch("userlist_status.jsp", request, response);
//		}else if(command.equals("alluserlist")){
//			List<UserDto> list = dao.getAllUserList();
//			request.setAttribute("list", list);
//			dispatch("userlist.jsp", request, response);
//		}else if(command.equals("roleForm")){
//			String rid = request.getParameter("rid");
//			UserDto dto = dao.getUser(rid); //등급을 변경하려는 회원의 정보를 구함
//			request.setAttribute("dto", dto);
//			dispatch("authfrom.jsp", request, response);
//		}else if(command.equals("authchange")){
//			String rid = request.getParameter("rid");
//			String rrole = request.getParameter("rrole");
//			boolean isS = dao.updateUserRole(rid, rrole);
//			if(isS){
//				jsForward("LoginController.do?command=alluserlist","회원등급을 수정했습니다.",response);
//			}else{
//				request.setAttribute("msg", "회원등급 변경실패");
//				dispatch("error.jsp", request, response);
//			}
//		}else if(command.equals("userinfo")){
//			String rid = request.getParameter("rid");
//			UserDto dto = dao.userinfo(rid);
//			request.setAttribute("dto", dto);
//			dispatch("user_info.jsp", request, response);
//		}else if(command.equals("userUpdate")){
//			String rid = request.getParameter("rid");
//			UserDto dto = dao.userinfo(rid);
//			request.setAttribute("dto", dto);
//			dispatch("userupdate.jsp", request, response);
//		}else if(command.equals("update")){
//			String rid = request.getParameter("rid");
//			String raddress = request.getParameter("raddress");
//			String rphone = request.getParameter("rphone");
//			String remail = request.getParameter("remail");
//			boolean isS = dao.userUpdate(new UserDto(rid,raddress,rphone,remail));
//			if(isS){
//				jsForward("LoginController.do?command=userinfo&rid="+rid,"회원정보을 수정했습니다.",response);
//			}else{
//				request.setAttribute("msg", "회원정보 수정실패");
//				dispatch("error.jsp", request, response);
//			}
//		}else if(command.equals("withdraw")){
//			String rid = request.getParameter("rid");
//			boolean isS = dao.withdraw(rid);
//			if(isS){
//				jsForward("LoginController.do?command=logout","탈퇴하였습니다.",response);
//			}else{
//				request.setAttribute("msg", "회원 탈퇴실패");
//				dispatch("error.jsp", request, response);
//			}
//		}else if(command.equals("boardlist")){
//			dispatch("BoardController.do?command=boardlist", request, response);
//		}
		
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
