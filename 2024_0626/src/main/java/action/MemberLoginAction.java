package action;

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

		request.setCharacterEncoding("utf-8");
		String mem_id = request.getParameter("mem_id");
		String mem_pwd = request.getParameter("mem_pwd");
		
		MemberVo user = MemberDao.getInstance().selectOne(mem_id);
		
		if(user==null) { // 해당하는 아이디가 없기에 false를 반환한다.
			response.sendRedirect("login_form.do?reason=fail_id");
			return;
		}
		
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			return;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		response.sendRedirect("list.do");

	}

}