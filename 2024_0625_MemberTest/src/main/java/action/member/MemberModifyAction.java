package action.member;

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
 * Servlet implementation class MemberModifyAction
 */
@WebServlet("/member/modify.do")
public class MemberModifyAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// /member/modify.do?mem_idx=7&mem_name=이름석자&mem_id=ㅁㄴㄻㄴㄹ&mem_pwd=sfafas
		// &mem_zipcode=55712&mem_addr=전북특별자치도+남원시+아영면+흥부로+16&mem_grade=일반
		request.setCharacterEncoding("utf-8");
		
		int mem_idx = Integer.parseInt(request.getParameter("mem_idx"));
		String mem_name = request.getParameter("mem_name");
		String mem_id = request.getParameter("mem_id");
		String mem_pwd = request.getParameter("mem_pwd");
		String mem_zipcode = request.getParameter("mem_zipcode");
		String mem_addr = request.getParameter("mem_addr");
		String mem_grade = request.getParameter("mem_grade");
		
		// vo 생성자
		MemberVo vo = new MemberVo(mem_name, mem_id, mem_pwd, mem_zipcode, mem_addr, mem_grade, mem_idx);
		
		int res = MemberDao.getInstance().update(vo);
		
		HttpSession session = request.getSession();
		MemberVo loginUser = (MemberVo) session.getAttribute("user");
		
		//현재수정정보가 로그인한 본인 유저인경우
		if(loginUser.getMem_idx()==mem_idx) {
			// 로그인 상태정보
			MemberVo user = MemberDao.getInstance().selectOne(mem_idx);
			
			
			// session.removeAttribute("user"); 이렇게 삭제할 필요가 없다. 그것은 Map구조를 이해하면 된다.
			// key, value 형태의 Map구조로 저장이 되는데, 똑같은 결과를 넣으면, 최신정보로 수정이 되어버린다.
			session.setAttribute("user", user);
		}
		
		
		// Redirect 형식으로 추출
		response.sendRedirect("list.do");

	}

}