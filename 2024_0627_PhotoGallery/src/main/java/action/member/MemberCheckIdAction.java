package action.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import db.vo.MemberVo;

/**
 * Servlet implementation class MemberCheckIdAction
 */
@WebServlet("/member/check_id.do")
public class MemberCheckIdAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// /member/check_id.do?mem_id=one
		// 이메일을 id로 받는 경우에 특수문자가 들어가기 때문에 수신 인코딩을 설정해준다.
		request.setCharacterEncoding("utf-8");
		// parameter 받기
		String mem_id = request.getParameter("mem_id");
		// mem_id에 해당되는 유저정보 검색
		MemberVo vo = MemberDao.getInstance().selectOne(mem_id);
		// 중복된 아이디를 검사하는 것이기 때문에, where mem_id = '검사 id'를 했을 때 그 값이 데이터 DB에 없으면 null 값이 나온다.
		Boolean bResult = (vo==null);
		
		/* if(vo==null) bResult=true;
		else bResult=false; */
		
		// 요청한 클라이언트에게 응답처리
		response.setContentType("application/json; charset=utf-8;");
		
		PrintWriter out = response.getWriter();
		
		String json = String.format("{\"result\": %b}", bResult);
		// 데이터를 하나만 보내기에 변수를 사용안하고 바로 보내준다.
		out.print(json);

	}
}