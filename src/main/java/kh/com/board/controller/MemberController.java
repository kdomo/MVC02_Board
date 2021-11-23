package kh.com.board.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		MemberDAO dao = MemberDAO.getInstance();
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		HttpSession session = request.getSession();
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
			boolean rs = dao.idCheck(id);

			RequestDispatcher rd = request.getRequestDispatcher("/member/idCheckPopup.jsp");
			request.setAttribute("id", id);
			if (rs) {
				request.setAttribute("rs", "unavailable");
			} else {
				request.setAttribute("rs", "available");
			}
			rd.forward(request, response);

		} else if (cmd.equals("/signupProc.mem")) { // 회원가입 버튼을 눌렀을때
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			String nickname = request.getParameter("nickname");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");

			System.out.println(id + " : " + password + " : " + nickname + " : " + phone + " : " + address);
			int rs = dao.insert(new MemberDTO(id, EncryptionUtils.getSHA512(password), nickname, phone, address,
					System.currentTimeMillis()));
			if (rs != -1)
				response.sendRedirect("/");
		} else if (cmd.equals("/loginProc.mem")) { // 로그인페이지에서 로그인버튼을 눌렀을때
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			boolean rs = dao.login(id, EncryptionUtils.getSHA512(password));

			if (rs) {//로그인 성공 시
				MemberDTO dto = dao.selectById(id);
				
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("id", id);
				map.put("nickname", dto.getNickname());
				
				
				
				System.out.println("로그인 성공");
				session.setAttribute("loginSession", map);
				response.sendRedirect("/");
			} else {
				System.out.println("로그인 실패");
				RequestDispatcher rd = request.getRequestDispatcher("/");
				request.setAttribute("rs", "fail");
				rd.forward(request, response);

			}

		} else if (cmd.equals("/logoutProc.mem")) {
			System.out.println("로그아웃");
			session.removeAttribute("loginSession");
			response.sendRedirect("/");
		} else if (cmd.equals("/mypageMove.mem")) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");
			MemberDTO dto = dao.selectById(id);
			if (dto != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/member/myPage.jsp");
				request.setAttribute("dto", dto);
				rd.forward(request, response);
			}
		} else if (cmd.equals("/wirhdrawProc.mem")) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");
			System.out.println("회원탈퇴 아이디 : " + id);
			int rs = dao.deleteById(id);
			if (rs == -1) {
				response.sendRedirect("/");
				session.invalidate();
			}
		} else if (cmd.equals("/modifyInfoProc.mem")) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");
			String nickname = request.getParameter("nickname");
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			
			System.out.println("nickname : "+nickname);
			System.out.println("address : "+address);
			System.out.println("phone : "+phone);
			
			int rs = dao.modifyById(id,nickname,address,phone);
			if(rs != -1) {
				response.sendRedirect("/mypageMove.mem");
			}
			
		}
	}
}
