package kh.com.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.board.dao.BoardDAO;
import kh.com.board.dto.BoardDTO;
import kh.com.board.service.BoardService;

/**
 * Servlet implementation class BoardController
 */
@WebServlet("*.bd")
public class BoardController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		HttpSession session = request.getSession();
		System.out.println(cmd);
		BoardDAO dao = BoardDAO.getInstance();

		if (cmd.equals("/writeMove.bd")) {
			response.sendRedirect("/board/write.jsp");
		} else if(cmd.equals("/boardMove.bd")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			BoardService service = new BoardService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<BoardDTO> list = service.getBoardList((int)naviMap.get("currentPage"));
			if(list!=null) {
				request.setAttribute("list", list);
				request.setAttribute("naviMap", naviMap);
				RequestDispatcher rd = request.getRequestDispatcher("/board/board.jsp");
				rd.forward(request, response);
			}
			
		} else if(cmd.equals("/writeProc.bd")) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");	
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String nickname = map.get("nickname");
			
			int rs = dao.write(new BoardDTO(title,content,nickname,id));
			if(rs != -1) {
				response.sendRedirect("/boardMove.bd?currentPage=1");
			}
		} else if(cmd.equals("/detailViewMove.bd")) {
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			int rs = dao.updateView_count(seq_board);
			BoardDTO dto = dao.selectBySeq(seq_board);
			if(dto!=null) {
				request.setAttribute("dto", dto);
				request.setAttribute("currentPage", currentPage);
				RequestDispatcher rd = request.getRequestDispatcher("/board/detailView.jsp");
				rd.forward(request, response);
			}
		} else if(cmd.equals("/deleteProc.bd")) {
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			int rs = dao.deleteBySeq(seq_board);
			if(rs != -1) {
				response.sendRedirect("/boardMove.bd?currentPage=1");
			}
		} else if(cmd.equals("/modifyProc.bd")) {
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			int rs = dao.modifyBySeq(seq_board,title,content);
			if(rs != -1) {
				response.sendRedirect("/detailViewMove.bd?seq_board="+seq_board+"&currentPage="+currentPage);
			}
		}
	}

}
