package com.codingdojo.java.week1.javafun.javaoop.smithsite.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.Comment;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.Event;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.User;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.UserEvent;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.repositories.CommentRepository;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.repositories.EventRepository;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.repositories.UserEventRepository;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.repositories.UserRepository;

@Service
public class ProjectService {
    private final UserRepository userRepository;
    private final CommentRepository cRepo;
    private final EventRepository eRepo;
    private final UserEventRepository uERepo;
    
    public ProjectService(UserRepository userRepository, CommentRepository cRepo,EventRepository eRepo, UserEventRepository uERepo) {
        this.userRepository = userRepository;
        this.cRepo = cRepo;
        this.eRepo = eRepo;
        this.uERepo = uERepo;
    }
    
    // register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    public Event createEvent(Event event, Long id) {
    	event.setUser(findUserById(id));
    	return eRepo.save(event);
    }
    public List<Event> sameStateEvents(String state){
    	return eRepo.findByStateContains(state);
    }
    public List<Event> outsideStateEvents(String state){
    	return eRepo.findByStateNotContains(state);
    }
    
    public Event eventById(Long id) {
    	if(eRepo.findById(id) !=null) {
    		return eRepo.findById(id).get();
    	}
    	else {
    		return null;
    	}
    }
    
    public void deleteEventById(Long id) {
    	eRepo.deleteById(id);
    }
    
    public void updateEvent(Event event) {
    	eRepo.save(event);
    }
    public UserEvent userJoinEvent(UserEvent join) {
    	return uERepo.save(join);
    }
    public Iterable<UserEvent> joinedEvents(){
    	return uERepo.findAll();
    }
    
    public void deleteJoin(UserEvent userEvent) {
    	uERepo.delete(userEvent);
    }
    public UserEvent findJoinedEvent(Event event, User user) {
    	return uERepo.findByEventAndUser(event, user);
    }

    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepository.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }

	public Comment addComment(Comment comment) {
		return cRepo.save(comment);
		
	}
}
