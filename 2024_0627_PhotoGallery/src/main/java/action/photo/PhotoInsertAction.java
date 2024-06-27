package action.photo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.vo.MemberVo;

/**
 * Servlet implementation class PhotoInsertAction
 */
@WebServlet("/photo/insert.do")
public class PhotoInsertAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// photo/insert.do?p_title=제목&p_content=내용&photo=notebook.png
		// 30분이 지나면 글못올리게 만들어야함
		// 로그인 상태 체크
		HttpSession session = request.getSession();
		
		MemberVo user = (MemberVo) session.getAttribute("user");
		// session timeout
		if(user==null) {
			response.sendRedirect("../member/login_form.do?reason=session_timeout");
			return;
		}

	}

}