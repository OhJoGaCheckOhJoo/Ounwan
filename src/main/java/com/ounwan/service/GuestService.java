package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.GuestsDTO;
import com.ounwan.entity.Guests;
import com.ounwan.repository.GuestDAO;

@Service
public class GuestService {
	
	@Autowired
	GuestDAO guestDAO;

	public boolean addGuestInfo(GuestsDTO guest) {
		int result = guestDAO.addGuestInfo(changeToEntity(guest));
		return (result > 0) ? true : false;
	}

	public Guests changeToEntity(GuestsDTO guest) {
		if (guest.getGuestNumber() == null)
			guest.setGuestNumber(0);
		
		return Guests.builder()
					.guestNumber(guest.getGuestNumber())
					.email(guest.getEmail())
					.phone(guest.getPhone())
					.build();
	}

}
