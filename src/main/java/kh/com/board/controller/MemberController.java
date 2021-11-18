package kh.com.board.controller;

import java.io.Console;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.com.board.dao.MemberDAO;

@WebServlet("*.mem")
public class MemberController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println(cmd);
		
		
		if (cmd.equals("/signupMove.mem")) {
			response.sendRedirect("/member/signup.jsp");
		} else if (cmd.equals("/idCheckPopup.mem")) {
			response.sendRedirect("/member/idCheckPopup.jsp");
		} else if (cmd.equals("/idCheckProc.mem")) {
			String idInput = request.getParameter("idInput");
			MemberDAO dao = MemberDAO.getInstance();
			boolean rs = dao.idCheck(idInput);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/idCheckPopup.jsp");
			request.setAttribute("idInput", idInput);
			if(rs) {
				request.setAttribute("rs", "unavailable");
			}else {
				request.setAttribute("rs", "available");
			}
			rd.forward(request, response);

		}
	}
}
