package game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WordDBBean {

    @Autowired
    private WordMapper wordMapper;

    public void insertGameRecord(WordDataBean dto) {
        wordMapper.insertGameRecord(dto);
    }
}