package action;

import java.io.IOException;

import dao.MemberDao;
import db.vo.MemberVo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberInsertAction
 */
@WebServlet("/member/insert.do")
public class MemberInsertAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		// /member/insert.do?mem_name=차선일&mem_id=차선일&mem_pwd=5555&mem_nickname=차선일&mem_zipcode=06097&mem_addr=서울+강남구+봉은사로+403
		String mem_name = request.getParameter("mem_name");
		String mem_id = request.getParameter("mem_id");
		String mem_pwd = request.getParameter("mem_pwd");
		String mem_nickname = request.getParameter("mem_nickname");
		String mem_zipcode = request.getParameter("mem_zipcode");
		String mem_addr = request.getParameter("mem_addr");
		String mem_ip = request.getRemoteAddr();
		
		MemberVo vo = new MemberVo(mem_name, mem_id, mem_pwd, mem_nickname, mem_zipcode, mem_addr, mem_ip);
		
		int res = MemberDao.getInstance().insert(vo);
		
		response.sendRedirect("list.do");

	}

}
