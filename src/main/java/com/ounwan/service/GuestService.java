package com.ounwan.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.entity.Guests;
import com.ounwan.repository.GuestDAO;

@Service
public class GuestService {
	
	@Autowired
	GuestDAO guestDAO;
	@Autowired
	OrderService orderService;

	public GuestsDTO addGuestInfo(GuestsDTO guest) {
		Guests entity = changeToEntity(guest);
		int result = guestDAO.addGuestInfo(entity);
		return (result > 0) ? changeToDTO(entity) : null;
	}

	public OrdersDTO getGuestInfo(GuestsDTO guestDTO) {
		Map<String, Object> guest = new HashMap<>();
		guest.put("guestEmail", guestDTO.getEmail());
		guest.put("orderNumber", guestDTO.getOrderNumber());
		
		int result = guestDAO.getGuestInfo(guest);
		if (result > 0) 
			return orderService.getOrders(guestDTO.getOrderNumber());
		return null;
	}


	public Guests changeToEntity(GuestsDTO guest) {
		if(guest.getGuestNumber() == null)
			guest.setGuestNumber(0);
		return Guests.builder()
					.guestNumber(guest.getGuestNumber())
					.email(guest.getEmail())
					.phone(guest.getPhone())
					.build();
	}
	
	public GuestsDTO changeToDTO(Guests guest) {
		return GuestsDTO.builder()
						.guestNumber(guest.getGuestNumber())
						.email(guest.getEmail())
						.phone(guest.getPhone())
						.build();
	}
}
