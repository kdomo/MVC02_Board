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
			ArrayList<BoardDTO> list = dao.selectAll();
			
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/board/board.jsp");
			rd.forward(request, response);
		} else if(cmd.equals("/writeProc.bd")) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String nickname = map.get("nickname");
			
			int rs = dao.write(new BoardDTO(title,content,nickname,id));
			if(rs != -1) {
				response.sendRedirect("/boardMove.bd");
			}
		}
	}

}
