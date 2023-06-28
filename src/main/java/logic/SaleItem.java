package logic;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class SaleItem {
	private int saleid;	// 주문 번호
	private int seq;	// 주문 상품 번호
	private int itemid; // 상품 아이디
	private int quantity; // 주문 상품 수량
	private Item item; // 상품 아이디에 해당하는 상품 정보
	
	public SaleItem(int saleid, int seq, ItemSet itemSet) {
		this.saleid = saleid;
		this.seq = seq;
		this.item = itemSet.getItem();
		this.itemid = itemSet.getItem().getId(); // 상품 id
		this.quantity = itemSet.getQuantity(); // 주문 수량
	}
}
