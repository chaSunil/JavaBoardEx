package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBService {
	
	// single-ton pattern : 객체 1개만 생성해서 사용하자
	static DBService single = null;
	DataSource ds = null;

	public static DBService getInstance() {
		// 없으면 생성해라
		if (single == null) {
			single = new DBService();
		}
		return single;
	}

	private DBService() {
		
		try {
			// JNDI를 이용해서 DataSource정보를 얻어온다
			// 1. InitialContext 생성(JNDI->interface 추출객체)
			InitialContext ic = new InitialContext();
			
			// 2. Context정보 얻어온다(look up 함수가 Object랑 연관되어 있어서 Casting 해주었음)
			Context context = (Context) ic.lookup("java:comp/env");
			
			// 3. naming을 이용해서 DataSource 얻어온다
			ds = (DataSource) context.lookup("jdbc/oracle_test");
			
			// 2+3 한번에
			// ds = (DataSource) ic.lookup("java:comp/env/jdbc/oracle_test");
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}//end:DBService()
	
	public Connection getConnection() throws SQLException {
		// DataSource를 이용해서 BasicDataSource가 관리하고 있는 Connection을 요청
		return ds.getConnection();
	}
	
}