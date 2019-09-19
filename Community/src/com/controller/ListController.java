package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daos.ListDao;
import com.dtos.ListDto;
import com.utils.Paging;

@WebServlet("/ListController.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String command = request.getParameter("command");
		
		ListDao dao = new ListDao();
		
		if(command.equals("addlistfrom")){
			response.sendRedirect("addlistfrom.jsp");
		}else if(command.equals("addlist")){
			String enabled = request.getParameter("enabled");
			String kind = request.getParameter("kind");
			String kindcontent = request.getParameter("kindcontent");
			
			boolean isS = dao.addlist(new ListDto(enabled,kind,kindcontent));
			
			if(isS){
				if(enabled.equals("N")) {
					jsForward("LoginController.do?command=index", "게시판을 신청하였습니다", response);
				}else {
					jsForward("LoginController.do?command=index", "게시판을 추가하였습니다", response);
				}
			}else{
				if(enabled.equals("N")) {
					request.setAttribute("msg", "게시판 신청 실패");
				}else {
					request.setAttribute("msg", "게시판 추가 실패");
				}
				
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("listadmin")){
			String listpNum = request.getParameter("listpNum");
			ListDao listdao = new ListDao();
			List<ListDto> blist = listdao.sublist();
			List<ListDto> alist = listdao.setUplist(listpNum);
			
			int pcount = listdao.listPageMax();
			Map<String,Integer> map = Paging.pagingValue(pcount, listpNum, 5);
			
			request.setAttribute("listpNum", listpNum);
			request.setAttribute("map", map);
			request.setAttribute("alist", alist);
			if(blist != null) {
				request.setAttribute("blist", blist);
			}
			dispatch("listadmin.jsp", request, response);
		}else if(command.equals("openlist")){
			String[] kindseqs = request.getParameterValues("chk");
			boolean isS = dao.openlist(kindseqs);
			if(isS) {
				response.sendRedirect("ListController.do?command=listadmin&listpNum=1");
			}else {
				request.setAttribute("msg", "개설 실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("changelist")){
			String kindseq = request.getParameter("kindseq");
			String enabled = request.getParameter("enabled");
			
			boolean isS = dao.changelist(kindseq,enabled);
			if(isS) {
				response.sendRedirect("ListController.do?command=listadmin&listpNum=1");
			}else {
				request.setAttribute("msg", "개설 실패");
				dispatch("error.jsp", request, response);
			}
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
