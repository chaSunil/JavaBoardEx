package action;

import java.io.IOException;
import java.io.PrintWriter;

import dao.MemberDao;
import db.vo.MemberVo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberCheckIdAction
 */
@WebServlet("/member/check_nickname.do")
public class MemberCheckNicknameAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String mem_nickname = request.getParameter("mem_nickname");
		
		MemberVo vo = MemberDao.getInstance().selectOne2(mem_nickname);
		// vo에 null 값은 중복된 id가 없다는 것이기 때문에 true를 반환하면 된다.
		Boolean bResult = (vo==null);
		
		response.setContentType("application/json; charset=utf-8;");
		
		PrintWriter out = response.getWriter();
		
		String json = String.format("{\"result\": %b}", bResult);
		out.print(json);
	}

}