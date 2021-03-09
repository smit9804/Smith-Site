package com.codingdojo.java.week1.javafun.javaoop.smithsite.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.Comment;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.Event;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.User;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.models.UserEvent;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.services.ProjectService;
import com.codingdojo.java.week1.javafun.javaoop.smithsite.validators.uVal;

@Controller
public class SmithController {
	private final ProjectService pServ;
	private final uVal uVal;
	
	public SmithController(ProjectService pServ) {
		this.pServ = pServ;
		this.uVal = new uVal();
	}
	
	@GetMapping("/")
	public String home(@ModelAttribute("user") User user, HttpSession session) {
		if(session.isNew()) {
			session.setAttribute("login", false);
		}
		
		return "loginreg.jsp";
	}
	
	@PostMapping("/registration")
	public String registerUser(@Valid @ModelAttribute("user")User user, BindingResult result, HttpSession session) {
		uVal.validate(user, result);
		if(result.hasErrors()) {
			return "loginreg.jsp";
		}
		
		else{
			session.setAttribute("user", (Long) pServ.registerUser(user).getId());
			session.setAttribute("login", true);

		
		return "redirect:/events";
		}
	}
	@RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
          if (pServ.authenticateUser(email, password)) {
              session.setAttribute("user", (Long) pServ.findByEmail(email).getId());
              session.setAttribute("login", true);
              return "redirect:/events";
          } else {
              redirectAttributes.addFlashAttribute("error",  "Are you sure you are registered");
              model.addAttribute("error", "Not authenticated");
              return "redirect:/";
         }
	}
	@GetMapping("/events")
	public String homePage(HttpSession session,Model model,@ModelAttribute("eventForm")Event event) {
		if((boolean)session.getAttribute("login") == true) {
			User user = pServ.findUserById((Long)session.getAttribute("user"));
			model.addAttribute("user", pServ.findUserById((Long)session.getAttribute("user")));
			model.addAttribute("inState",pServ.sameStateEvents(user.getState()));
			model.addAttribute("outState",pServ.outsideStateEvents(user.getState()));
			model.addAttribute("joinsEvent",pServ.joinedEvents());
			return "home.jsp";
		}
		else {
			return"redirect:/";
		}
	}
	@PostMapping("/events")
	public String createEvent(@Valid @ModelAttribute("eventForm")Event event,BindingResult result,HttpSession session,Model model) {
		if(result.hasErrors()) {
			model.addAttribute("user", pServ.findUserById((Long)session.getAttribute("user")));
			User user = pServ.findUserById((Long)session.getAttribute("user"));
			model.addAttribute("user", pServ.findUserById((Long)session.getAttribute("user")));
			model.addAttribute("inState",pServ.sameStateEvents(user.getState()));
			model.addAttribute("outState",pServ.outsideStateEvents(user.getState()));
			return"home.jsp";
		}
		else {
			Event newEvent = pServ.createEvent(event,(Long) session.getAttribute("user"));
			return"redirect:/events/"+newEvent.getId();
		}
	}
	@GetMapping("/events/{eventId}")
	public String eventInfo(@PathVariable("eventId")Long eId,Model model,HttpSession session,@ModelAttribute("addComment")Comment comment) {
		if((boolean)session.getAttribute("login") == true) {
			model.addAttribute("event",pServ.eventById(eId));
			model.addAttribute("user",pServ.findUserById((Long)session.getAttribute("user")));
			return "events.jsp";
		}
		else {
			return "redirect:/";
		}
	}	
	@PostMapping("/events/{eventId}")
	public String addComment(@PathVariable("eventId")Long eId,HttpSession session,@Valid @ModelAttribute("addComment")Comment comment,BindingResult result,Model model) {
		if(result.hasErrors()) {
			if((boolean)session.getAttribute("login") == true) {
				model.addAttribute("event",pServ.eventById(eId));
				model.addAttribute("user",pServ.findUserById((Long)session.getAttribute("user")));
				return "events.jsp";
			}
			else {
				return "redirect:/";
			}
		}
		else {
			User user = pServ.findUserById((Long)session.getAttribute("user"));
			comment.setUser(user);
			comment.setEvent(pServ.eventById(eId));
			pServ.addComment(comment);
			return "redirect:/events/"+eId;
		}
	}
	@GetMapping("events/edit/{eventId}")
	public String editEvent(@ModelAttribute("event")Event event,@PathVariable("eventId")Long id,Model model,HttpSession session) {
		
		if((boolean)session.getAttribute("login") == true) {
			model.addAttribute("event",pServ.eventById(id));
			return"edit.jsp";
		}
		else {
			return"redirect:/";
		}
	}
	
	@PutMapping("events/{eventId}")
	public String updateEvent(@Valid @ModelAttribute("event")Event event,BindingResult result,@PathVariable("eventId")Long id,Model model, HttpSession session) {
		User user = pServ.findUserById((Long)session.getAttribute("user"));
		if(pServ.eventById(id).getUser().getId() == user.getId() ) {
			if(result.hasErrors()) {
				model.addAttribute("event",pServ.eventById(id));
				return"edit.jsp";
			}
			else {
				event.setId(id);
				event.setUser(user);
				pServ.updateEvent(event);
				return"redirect:/events";
			}
			
		}
		else {
			return"redirect:/";
		}
	}
	
	@DeleteMapping("/events/{eventId}")
	public String deleteEvent(@PathVariable("eventId")Long id,@RequestParam("userId")Long uId) {
		Event event = pServ.eventById(id);
		User user = pServ.findUserById(uId);
		
		if(event.getUser().getId() == user.getId()) {
			pServ.deleteEventById(id);
			return"redirect:/events";
		}
		else {
			return"redirect:/logout";
		}
		
		
	}
	@PostMapping("/events/join")
	public String joinEvent (@Valid @ModelAttribute("userEvent")UserEvent join,BindingResult result,@RequestParam("event")Long event, @RequestParam("user")Long user) {
		if(result.hasErrors()) {
			return"home.jsp";
		}
		else {
			join.setUser(pServ.findUserById(user));
			join.setEvent(pServ.eventById(event));
			pServ.userJoinEvent(join);
			return"redirect:/events";
		}
	}
	@DeleteMapping("/events/cancel")
	public String cancelJoin(@RequestParam("userId")Long uId,@RequestParam("eventId")Long eId) {
		User user = pServ.findUserById(uId);
		Event event = pServ.eventById(eId);
		UserEvent cancel = pServ.findJoinedEvent(event, user);
		pServ.deleteJoin(cancel);
		return"redirect:/events";
	}
	@RequestMapping("/logout")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return"redirect:/";
    }
	@RequestMapping("/help")
	public String help() {
		return "help.jsp";
	}
}
