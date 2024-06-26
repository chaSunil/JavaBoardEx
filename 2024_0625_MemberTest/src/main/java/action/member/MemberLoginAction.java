package action.member;

import java.io.IOException;

import dao.MemberDao;
import db.vo.MemberVo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class MemberLoginAction
 */
@WebServlet("/member/login.do")
public class MemberLoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 로그인 후 다른 화면으로 가야하기에, redirect 해준다.
		// login.do?mem_id=dad&mem_pwd=dad
		
		// 0. 수신인코딩 설정하기
		request.setCharacterEncoding("utf-8");
		// 1. parameter 받기
		String mem_id = request.getParameter("mem_id");
		String mem_pwd = request.getParameter("mem_pwd");
		// 2. mem_id를 이용해서 MemberVo를 얻어온다
		MemberVo user = MemberDao.getInstance().selectOne(mem_id);
		
		if(user==null) { // 아이디가 없는(틀린) 경우
			// 아이디가 틀렸으니 reason=fail_id라고 값을 다시 보내준다.
			//					 Session Tracking 방법 중 하나 (GET)
			response.sendRedirect("login_form.do?reason=fail_id");
			return;
		}
		
		// 비밀번호가 틀린 경우
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			return;
		}
		
		// 로그인 완료시 : 현재 로그인된 객체(user)정보를 session에 저장
		HttpSession session = request.getSession();
		// user안에는 name,id,pwd등등 모든 정보가 들어있는 객체가 들어있다.
		session.setAttribute("user", user);
		
		// main 페이지 이동
		response.sendRedirect("list.do");

	}

}