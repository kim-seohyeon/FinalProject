package shoppingmall.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DuplicationRepository {
	@Autowired
	SqlSession sqlSession;
	String namespace = "duplicationSql";
	String statement;
	public String idCheckSelectOne(String userId) {
		statement = namespace + ".idcheck";
		return sqlSession.selectOne(statement, userId);
	}
	
	public String emailCheckSelectOne(String userEmail) {
		statement = namespace + ".emailcheck";
		return sqlSession.selectOne(statement, userEmail);
	}
}
