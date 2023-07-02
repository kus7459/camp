package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Sale {
	private int saleid;
	private String userid;
	private int itemid;
	private String name;
	private int quantity;
	private int total;
	private String pictureUrl;
	private int postcode;
	private String address;
	private String detailAddress;
	private Date saledate;
}
