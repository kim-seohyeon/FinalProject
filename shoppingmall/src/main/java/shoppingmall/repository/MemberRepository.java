package shoppingmall.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CartListDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.PurchaseDTO;
import shoppingmall.domain.UserChangePasswordDTO;

@Repository
public class MemberRepository {

	@Autowired
	SqlSession sqlSession;
	String namespace="memberSql";
	String statement;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;
	
	public String autoMemberNum() {
		sql = " select concat('mem_', nvl(substr(max(MEMBER_NUM),5),10000)+1) from members";
		//queryForObject : row가 하나일 때
		return jdbcTemplate.queryForObject(sql, String.class);
	}
	
    // 회원 추가
	public int memberInsert(MemberDTO dto) {
		sql = " insert into members(MEMBER_NUM, MEMBER_ID, MEMBER_NAME, MEMBER_PW"
				+ "					, MEMBER_ADDR, MEMBER_ADDR_DETAIL, MEMBER_POST, MEMBER_REGIST"
				+ "					, MEMBER_GENDER, MEMBER_PHONE1, MEMBER_PHONE2, MEMBER_EMAIL"
				+ "					, MEMBER_BIRTH)"
				+ " values(?, ?, ?, ? "
				+ "		 , ?, ?, ?, ?"
				+ "		 , ?, ?, ?, ?"
				+ "		 , ?)";
		                              
		return jdbcTemplate.update(sql, dto.getMemberNum(), dto.getMemberId(), dto.getMemberName(), dto.getMemberPw()
									   , dto.getMemberAddr(), dto.getMemberAddrDetail(), dto.getMemberPost(), dto.getMemberRegist()
									   , dto.getMemberGender(), dto.getMemberPhone1(), dto.getMemberPhone2(), dto.getMemberEmail()
									   , dto.getMemberBirth());
	}

    // 전체 회원 조회
	public List<MemberDTO> memberSelectAll() {

		sql = " select MEMBER_NUM, MEMBER_ID, MEMBER_NAME, MEMBER_PW"
				+ " 	, MEMBER_ADDR, MEMBER_ADDR_DETAIL, MEMBER_POST, MEMBER_REGIST"
				+ " 	, MEMBER_GENDER, MEMBER_PHONE1, MEMBER_PHONE2, MEMBER_EMAIL"
				+ " 	, MEMBER_BIRTH"
				+ " from members order by member_num desc";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<MemberDTO>(MemberDTO.class));
	}

    // 특정 회원 조회
	public MemberDTO memberSelectOne(String memberId) {

		sql = " select MEMBER_NUM, MEMBER_ID, MEMBER_NAME, MEMBER_PW"
				+ " 	, MEMBER_ADDR, MEMBER_ADDR_DETAIL, MEMBER_POST, MEMBER_REGIST memberRegist"
				+ " 	, MEMBER_GENDER memberGender, MEMBER_PHONE1, MEMBER_PHONE2, MEMBER_EMAIL"
				+ " 	, MEMBER_BIRTH memberBirth"
				+ " from members where member_id = ?";
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(MemberDTO.class), memberId);
	}

    // 회원 정보 수정
	public int memberUpdate(MemberDTO dto) {
		
		sql = " update members"
				+ " set   MEMBER_NAME = ?, MEMBER_ADDR = ?, MEMBER_ADDR_DETAIL = ?"
				+ "		, MEMBER_POST = ?, MEMBER_PHONE1 = ?, MEMBER_PHONE2 = ?"
				+ "		, MEMBER_EMAIL = ?, MEMBER_BIRTH = ?"
				+ " where member_id = ?";

		return jdbcTemplate.update(sql, dto.getMemberName(), dto.getMemberAddr(), dto.getMemberAddrDetail()
									   , dto.getMemberPost(), dto.getMemberPhone1(), dto.getMemberPhone2()
									   , dto.getMemberEmail(), dto.getMemberBirth(), dto.getMemberId());
		
	}

    // 회원 삭제
	public int memberDelete(String memberId) {
		sql = " delete from members where member_id = ?";
		return jdbcTemplate.update(sql, memberId);
	}

    // 로그인 정보 조회
	public AuthInfoDTO loginSelectOne(String userId) {
		statement = namespace + ".memberSelectOne";
		return sqlSession.selectOne(statement, userId);	
	}

    // 비밀번호 수정
	public int userPwUpdate(UserChangePasswordDTO dto) {
		statement = namespace + ".userPwUpdate";
		return sqlSession.update(statement, dto);	
	}

    // 이메일 확인 및 업데이트
	public Integer emailCheckUpdate(String userId) {
		statement = namespace + ".emailCheckUpdate";
		return sqlSession.update(statement, userId);		
		
	}

    // 아이디 중복 체크
	public List<String> selectId(Map<String, String> map) {
		statement = namespace + ".selectId";
		return sqlSession.selectList(statement, map);
	}

    // 구매 이력 저장
    public int purchaseInsert(PurchaseDTO dto) {
        sql = "insert into purchase (purchase_num, purchase_name, purchase_price, delivery_name, delivery_addr, delivery_post, delivery_phone, message, member_num) "
              + "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
                dto.getPurchaseNum(), 
                dto.getPurchaseName(), 
                dto.getPurchasePrice(), 
                dto.getDeliveryName(),
                dto.getDeliveryAddr(),
                dto.getDeliveryPost(),
                dto.getDeliveryPhone(),
                dto.getMessage(),
                dto.getMemberNum());
    }

    // 구매 상품 리스트 저장
    public int purchaseListInsert(String goodsNum, String purchaseNum, String memberNum) {
        sql = "insert into purchase_list (goods_num, purchase_num, member_num) values (?, ?, ?)";
        return jdbcTemplate.update(sql, goodsNum, purchaseNum, memberNum);
    }

    // 장바구니에서 상품 삭제
    public int cartDelete(String goodsNum, String memberNum) {
        sql = "delete from cart where goods_num = ? and member_num = ?";
        return jdbcTemplate.update(sql, goodsNum, memberNum);
    }

    // 상품 정보 조회
    public List<CartListDTO> itemSelectOne(String goodsNum, String memberNum) {
        sql = "select c.CART_NUM, c.CART_QTY, g.GOODS_NUM, g.GOODS_NAME, g.GOODS_PRICE, "
                + "g.GOODS_MAIN_STORE_IMAGE, c.MEMBER_NUM "
                + "from cart c join goods g on c.GOODS_NUM = g.GOODS_NUM "
                + "where c.GOODS_NUM = ? and c.MEMBER_NUM = ?";
        
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<CartListDTO>(CartListDTO.class), goodsNum, memberNum);
    }

    //비밀번호 변경
	public int memberPwUpdate(String memberId, String newPw) {
		sql = " update members"
				+ " set member_pw = ? "
				+ " where member_id = ? ";
		return jdbcTemplate.update(sql, newPw, memberId);
		
		
	}

	//전화번호로 아이디 찾기
	public String findUserIdByPhone(String userPhone) {
        String sql = "SELECT MEMBER_ID FROM members WHERE MEMBER_PHONE1 = ? or member_phone2 = ?";
        return jdbcTemplate.queryForObject(sql, String.class, userPhone, userPhone);
	}

}