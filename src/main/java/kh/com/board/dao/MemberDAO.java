package kh.com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.board.dto.MemberDTO;


public class MemberDAO {
	private BasicDataSource bds = new BasicDataSource();
	private static MemberDAO instance = null;
	
	private MemberDAO() {
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "board_manager";
		String password = "manager";
		
		bds.setDriverClassName(className);
		bds.setUrl(url);
		bds.setUsername(username);
		bds.setPassword(password);
		bds.setInitialSize(30);		
	}
	
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}
	
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public int insert(MemberDTO dto) {
		String sql = "insert into tbl_member values(?,?,?,?,?,?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getPhone());
			pstmt.setString(5, dto.getAddress());
			pstmt.setString(6, dto.getSignup_date());
			
			int rs = pstmt.executeUpdate();
			if(rs != 0) return rs;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean idCheck(String id) {
		String sql = "select * from tbl_member where id=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}else {
				return false;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean login(String id,String password) {
		String sql = "select * from tbl_member where id=? AND password=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}else {
				return false;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
