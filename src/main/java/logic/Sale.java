package logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Sale {
	private int saleid;
	private String id;
	private Date saledate;
	private User user;
	private List<SaleItem> itemList = new ArrayList<>();
	
	public int getTotal() {
		return itemList.stream().mapToInt(s->s.getItem().getPrice() * s.getQuantity()).sum(); 
	}
}
