package action.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import db.vo.MemberVo;

/**
 * Servlet implementation class MemberDeleteAction
 */
@WebServlet("/member/delete.do")
public class MemberDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Redirect 방식으로 사용
		// /member/delete.do?mem_idx=3
		// 1. parameter 받기
		int mem_idx = Integer.parseInt(request.getParameter("mem_idx"));
		
		
		// 관리자가 아닌 일반 계정이면, session 만료
		// 2. 로그인한 유저가 일반 / 관리자 인지 판단
		HttpSession session = request.getSession();
		// Scope 영역에는 모든 타입을 저장할 수 있게 설정했기에 Object 타입으로 받게 되어있다.
		// MemberVo는 Object 타입의 자식이기에 다운캐스팅 해야 사용이 가능하다.
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		// 로그인 유저가 일반유저면 로그인정보 삭제
		if(user.getMem_grade().equals("일반")) {
			session.removeAttribute("user");
		}
		
		// 3. 삭제 DB delete
		if(user.getMem_grade().equals("관리자") && user.getMem_idx() == mem_idx) {
			response.sendRedirect("list.do?reason=fail_delete");
			return;
		} else {
			int res = MemberDao.getInstance().delete(mem_idx);
			response.sendRedirect("list.do");
		}
		

	}
}