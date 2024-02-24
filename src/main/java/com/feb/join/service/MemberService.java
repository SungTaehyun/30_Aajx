package com.feb.join.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.feb.join.dao.MemberDao;
import com.feb.join.dto.EmailDto;
import com.feb.join.util.EmailUtil;
import com.feb.join.util.Sha512Encoder;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailUtil emailUtil;
	
	/**
	 * ID 중복 검사
	 * @param memberId 컨트롤러에서 받은 사용자가 입력한 ID
	 * @return ID와 일치하는 row 갯수
	 */
	public int confirmId(String memberId) {
		return memberDao.confirmId(memberId);
	}
	
	/**
	 * 회원 가입
	 * 비밀 번호 암호화
	 * @param params 사용자가 입력한 회원가입정보
	 * @return int 가입 성공 시 1
	 */
	public int signUp(HashMap<String, String> params) {
		// 사용자가 입력한 비밀번호(평문) 암호화해서 Dao로 전송
		String passwd = params.get("passwd");
		String encodeTxt = Sha512Encoder.getInstance().getSecurePassword(passwd);
		params.put("passwd", encodeTxt);
		
		// 가입 성공 시 result 1, 웰컴 메일 발송
		int result = memberDao.signUp(params);
		if(result == 1) {
			EmailDto emailDto = new EmailDto();
			emailDto.setFrom("보내는 이 Email");
			emailDto.setReceiver(params.get("email"));
			emailDto.setSubject("회원가입을 환영합니다.");
			emailDto.setText(params.get("memberId") + "님의 가입을 진심으로 환영합니다.");
			
			// 메일 발송 실패 시 예외처리
			try {
				emailUtil.sendMail(emailDto);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return result;
	}
}
