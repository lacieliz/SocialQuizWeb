package game;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WordMapper {
    void insertGameRecord(WordDataBean dto);
}
