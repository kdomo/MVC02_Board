package kh.com.board.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.board.dto.BoardDTO;


public class BoardDAO {
	private BasicDataSource bds = new BasicDataSource();
	private static BoardDAO instance = null;

	private BoardDAO() {
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "board_manager";
		String password = "manager";

		bds.setDriverClassName(className);
		bds.setUrl(url);
		bds.setUsername(username);
		bds.setPassword(password);
		bds.setInitialSize(200);
	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}

	public int write(BoardDTO dto) {
		String sql = "insert into tbl_board values(seq_board.nextval,?,?,?,?,sysdate,0)";

		try (Connection con = this.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getWriter_id());

			int rs = pstmt.executeUpdate();
			if (rs != 0)
				return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<BoardDTO> selectAll(){
		String sql = "select * from tbl_board order by 1 desc";
		try( Connection con = this.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<BoardDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int seq_board = rs.getInt("seq_board");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String writer = rs.getString("writer");
				String writer_id = rs.getString("writer_id");
				Date written_data = rs.getDate("written_date");
				int view_count = rs.getInt("view_count");
				list.add(new BoardDTO(seq_board,title, content,writer,writer_id,written_data,view_count));
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
}
