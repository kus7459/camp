package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {
	@NotEmpty(message="아이디를 입력하세요")
	private String id;
	@Pattern(regexp="[a-zA-Z0-9]{8,16}", message="비밀번호는 영어, 숫자가 포함 된 8~16자리 비밀번호여야합니다.")
	private String pass;
	@NotEmpty(message="아이디를 입력하세요")
	private String name;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@NotNull(message="생일을 입력하세요.")
	private Date birth;
	private int gender;
	@NotEmpty(message="email을 입력하세요.")
	@Email(message="이메일 형식을 맞춰주세요")
	private String email;
	@NotEmpty(message="전화번호를 입력하세요")
	private String tel;
	
	private Date lastlog;

	
}
