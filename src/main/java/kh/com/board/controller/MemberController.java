package kh.com.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.com.board.dao.MemberDAO;
import kh.com.board.dto.MemberDTO;
import kh.com.board.utils.EncryptionUtils;

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
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		System.out.println(cmd);
		
		
		if (cmd.equals("/signupMove.mem")) {
			response.sendRedirect("/member/signup.jsp");
		} else if (cmd.equals("/idCheckPopup.mem")) {
			String id = request.getParameter("id");
			RequestDispatcher rd = request.getRequestDispatcher("/idCheckProc.mem");
			request.setAttribute("id", id);
			rd.forward(request, response);
			
		} else if (cmd.equals("/idCheckProc.mem")) {
			String id = request.getParameter("id");
			MemberDAO dao = MemberDAO.getInstance();
			boolean rs = dao.idCheck(id);
			
			RequestDispatcher rd = request.getRequestDispatcher("/member/idCheckPopup.jsp");
			request.setAttribute("id", id);
			if(rs) {
				request.setAttribute("rs", "unavailable");
			}else {
				request.setAttribute("rs", "available");
			}
			rd.forward(request, response);

		} else if(cmd.equals("/signupProc.mem")) { //회원가입 버튼을 눌렀을때
			String id = request.getParameter("id");
			String password = request.getParameter("password");	
			String nickname = request.getParameter("nickname");	
			String phone = request.getParameter("phone");	
			String address = request.getParameter("address");
			
			System.out.println(id +" : "+ password +" : "+ nickname +" : "+ phone +" : "+ address);
			MemberDAO dao = MemberDAO.getInstance();
			int rs = dao.insert(new MemberDTO(id,EncryptionUtils.getSHA512(password),nickname,phone,address,System.currentTimeMillis()));
			if(rs!=-1) response.sendRedirect("/");
		} else if(cmd.equals("/loginProc.mem")) { //로그인페이지에서 로그인버튼을 눌렀을때
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
		}
	}
}
