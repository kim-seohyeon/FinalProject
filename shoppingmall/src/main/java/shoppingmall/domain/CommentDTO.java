package shoppingmall.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class CommentDTO {

    private String commentNum;        // 댓글 번호 (PK)
    private String communityNum;      // 게시글 번호 (FK)
    private String writer;     // 댓글 작성자 이름
    private String content;    // 댓글 내용
    private Date commentDate;         // 댓글 작성일
    private String memberNum;
    private String memberId;

}