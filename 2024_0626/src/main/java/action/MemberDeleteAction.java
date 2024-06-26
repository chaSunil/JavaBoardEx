package action;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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

		int mem_idx = Integer.parseInt(request.getParameter("mem_idx"));
		
		HttpSession session = request.getSession();
		
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		if(user.getMem_grade().equals("일반")) {
			session.removeAttribute("user");
		}
		
		if(user.getMem_grade().equals("관리자") && user.getMem_idx() == mem_idx) {
			response.sendRedirect("list.do?reason=fail_delete");
			return;
		} else {
			int res = MemberDao.getInstance().delete(mem_idx);
		}
		
		
		response.sendRedirect("list.do");
	}

}