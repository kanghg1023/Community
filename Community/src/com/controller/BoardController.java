package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.daos.BoardDao;
import com.daos.CommentDao;
import com.daos.LikeDao;
import com.dtos.BoardDto;
import com.dtos.CommentDto;
import com.dtos.LikeDto;
import com.dtos.UserDto;
import com.utils.Paging;


@WebServlet("/BoardController.do")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//인코딩
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String command=request.getParameter("command");
		
		
		HttpSession session = request.getSession();
		BoardDao dao = new BoardDao();
		LikeDao likedao = new LikeDao();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		CommentDao cdao = new CommentDao();
		
		if(command.equals("boardlist")) { //목록보기
			//조회수 세션 삭제
			session.removeAttribute("readcount");
			
			String pNum = request.getParameter("pNum");
			if(pNum == null) {
				pNum = (String)request.getSession().getAttribute("pNum");
			}else {
				request.getSession().setAttribute("pNum", pNum);
			}
			
			String kindseq = request.getParameter("kindseq");
			if(kindseq == null) {
				kindseq = (String)session.getAttribute("kindseq");
			}else {
				session.setAttribute("kindseq", kindseq);
			}
			
			String search = request.getParameter("search");
			String searchType = request.getParameter("searchType");
			
			int pcount;
			List<BoardDto> list;
			if(search == null || search.equals("")) {
				list = dao.getAllList(kindseq,pNum);
				pcount = dao.pageMax(kindseq);
				request.setAttribute("searchType", "");
				request.setAttribute("search", "");
			}else {
				if(searchType.equals("title")) {
					list = dao.searchTitle(search,kindseq,pNum);
					pcount = dao.pageMaxSearchTitle(kindseq,search);
				}else {
					String email = dao.nickEmail(search);
					if(email == null) {
						email = "";
					}
					list = dao.searchEmail(email,kindseq,pNum);
					pcount = dao.pageMaxSearchEmail(kindseq,email);
				}
				request.setAttribute("searchType", searchType);
				request.setAttribute("search", search);
			}
			Map<String,Integer> map = Paging.pagingValue(pcount, pNum, 5);
			
			request.setAttribute("map", map);
			request.setAttribute("list", list);
			request.setAttribute("pcount", pcount);
			dispatch("boardlist.jsp",request, response);
		}else if(command.equals("insertForm")) { //글등록 페이지로
			response.sendRedirect("insertboard.jsp");
		}else if(command.equals("insertboard")) { //글등록
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String email = ldto.getEmail();
			String kindseq = (String)session.getAttribute("kindseq");
			
			boolean isS = dao.insertBoard(new BoardDto(title,content,email,kindseq));
			if(isS) {
				response.sendRedirect("BoardController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "글추가 실패");
				dispatch("error.jsp",request,response);
			}
		}else if(command.equals("boarddetail")) { //게시글 상세보기
			String kindseq = (String)session.getAttribute("kindseq");
			String seq=request.getParameter("seq");
			
			String rSeq = (String)session.getAttribute("readcount");
			
			//세션에 있으면 조회수가 늘지않음
			if(rSeq == null) {
				dao.readCount(seq);
				session.setAttribute("readcount", seq);
			}
			if(ldto != null) {
				boolean like = likedao.getLike(new LikeDto(ldto.getEmail(),seq));
				request.setAttribute("like", like);
			}
			int likecount = likedao.likeCount(seq);
			BoardDto dto = dao.getBoard(kindseq,seq);
			
			List<CommentDto> clist = cdao.commentList(seq);
			
			request.setAttribute("clist", clist);
			request.setAttribute("likecount", likecount);
			request.setAttribute("dto", dto);
			dispatch("boarddetail.jsp", request, response);
		}else if(command.equals("muldel")) { //삭제
			String[] seqs = request.getParameterValues("chk");
			boolean isS = dao.mulDel(seqs);
			if(isS) {
				response.sendRedirect("BoardController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "글여러개삭제 실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("updateForm")) {
			String kindseq = (String)session.getAttribute("kindseq");
			String seq = request.getParameter("seq");
			BoardDto dto = dao.getBoard(kindseq, seq);
			request.setAttribute("dto", dto);
			dispatch("updateboard.jsp", request, response);
		}else if(command.equals("updateboard")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS = dao.updateBoard(new BoardDto(seq,title,content));
			if(isS) {
				response.sendRedirect("BoardController.do?command=boarddetail&seq="+seq);
			}else {
				request.setAttribute("msg", "글수정 실패");
				dispatch("error.jsp",request,response);
			}
		}else if(command.equals("replyForm")) {
			String seq = request.getParameter("seq");
			request.setAttribute("seq", seq);
			dispatch("replyboard.jsp", request, response);
		}else if(command.equals("replyboard")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String email = ldto.getEmail();
			String kindseq = (String)session.getAttribute("kindseq");
			
			boolean isS = dao.replyBoard(new BoardDto(seq,title,content,email,kindseq));
			if(isS) {
				response.sendRedirect("BoardController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "답글달기 실패");
				dispatch("error.jsp",request,response);
			}
		}else if(command.equals("likechange")) {
			String seq = request.getParameter("seq");
			LikeDto dto = new LikeDto(ldto.getEmail(),seq);
			boolean like = likedao.getLike(dto);
			if(like) {
				//좋아요 삭제
				boolean isS = likedao.deleteLike(dto);
				if(isS) {
					like = false;
				}else {
					request.setAttribute("msg", "좋아요 삭제 실패");
					dispatch("error.jsp",request,response);
				}
			}else {
				//좋아요 추가
				boolean isS = likedao.insertLike(dto);
				if(isS) {
					like = true;
				}else {
					request.setAttribute("msg", "좋아요 추가 실패");
					dispatch("error.jsp",request,response);
				}
			}
			int likecount = likedao.likeCount(seq);
			
			PrintWriter pw = response.getWriter();
			pw.print(like+","+likecount);
		}else if(command.equals("addcomment")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			String content = request.getParameter("content");
			String email = ldto.getEmail();
//			addcomment
			boolean isS = cdao.addcomment(new CommentDto(0,seq,content,email));
			
			if(isS) {
				request.setAttribute("seq", seq);
				dispatch("BoardController.do?command=boarddetail", request, response);
			}else {
				request.setAttribute("msg", "댓글달기 실패");
				dispatch("error.jsp",request,response);
			}
		}else if(command.equals("recomment")) {
			int reseq = Integer.parseInt(request.getParameter("reseq"));
			int seq = Integer.parseInt(request.getParameter("seq"));
			String content = request.getParameter("content");
			String email = ldto.getEmail();
			
			boolean isS = cdao.recomment(new CommentDto(reseq,seq,content,email));
			
			if(isS) {
				request.setAttribute("seq", seq);
				dispatch("BoardController.do?command=boarddetail", request, response);
			}else {
				request.setAttribute("msg", "대댓글달기 실패");
				dispatch("error.jsp",request,response);
			}
		}
		else if(command.equals("delcomment")) {
			int reseq = Integer.parseInt(request.getParameter("reseq"));
			int seq = Integer.parseInt(request.getParameter("seq"));
			
			boolean isS = cdao.delcomment(reseq);
			
			if(isS) {
				request.setAttribute("seq", seq);
				dispatch("BoardController.do?command=boarddetail", request, response);
			}else {
				request.setAttribute("msg", "댓글삭제 실패");
				dispatch("error.jsp",request,response);
			}
		}
		
	}//doPost
	
	//RequestDispatcher 객체를 구해서 forward()할 수 있도록 구현한 메소드
	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}

}
