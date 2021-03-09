package com.codingdojo.java.week1.javafun.javaoop.smithsite.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.Event;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.User;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.UserEvent;

@Repository
public interface UserEventRepository extends CrudRepository<UserEvent,Long> {
	List<UserEvent> findByEventContains(Event event);
	UserEvent findByEventAndUser(Event event, User user);
	
}