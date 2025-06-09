package shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import shoppingmall.domain.LibraryDTO;
import shoppingmall.domain.StartEndPageDTO;

@Mapper
public interface LibraryMapper {

	LibraryDTO libSelectOne = null;

	public int libraryInsert(LibraryDTO dto);

	public List<LibraryDTO> libSelectList(StartEndPageDTO sepDTO);

	public LibraryDTO libSelectOne(int libNum);

	public int libraryDelete(int libNum);

	public int libraryUpdate(LibraryDTO dto);

	public int libraryCount(String searchWord);

	public void libraryNumsDelete(int[] nums);

	// 조회수 증가 메서드 추가
    public int incrementReadCount(int libNum);
}
