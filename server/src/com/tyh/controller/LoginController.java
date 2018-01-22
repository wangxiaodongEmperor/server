package com.tyh.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.ValidationException;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.reflect.TypeToken;
import com.tyh.entity.User;
import com.tyh.service.UserService;
import com.tyh.util.Constant;
import com.tyh.util.PropertiesUtil;
import com.tyh.util.Tools;


/**
 * @author wxd
 *
 */

@Controller
@SuppressWarnings("unchecked")
public class LoginController extends BaseCtrl{

	@Autowired
	private UserService userService;
	
	/**
	 * 未登录处理交易
	 * @return
	 */
	@RequestMapping(value="/loginerror",method=RequestMethod.GET)
	@ResponseBody
	public Map NotLoginno(){
		Map resultMap = new HashMap();  
		resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_ERROR);
		resultMap.put(Constant.RETURN_MSG, "登录超时，请您重新登录");
		System.out.println("lalalalal====================="+Constant.WEB_APP_CONTEXT.getMessage("lalalalal.aaaaa", null, null));
		
		return resultMap;
	}
	
	/**
	 * 登录交易
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Map loginPost(String username,String password,String gesture_password,String loginmode){
		Map resultMap = new HashMap();  
		BufferedReader reader;
		boolean result = false;
		String errInfo = "";
		String content="";
		
		System.out.println("session--------------------------"+session.getAttribute("User"));
		System.out.println("username--------------------------"+username);
		System.out.println("password--------------------------"+password);
		System.out.println("gesture_password--------------------------"+gesture_password);
		System.out.println("loginmode--------------------------"+loginmode);//登陆方式：F(手势登录) P(密码登陆);
		boolean status=userService.getCount(username);
		if(!status){
			errInfo="该用户名不存在";
		}else{
			if("F".equals(loginmode)){//手势登陆
				User user=userService.getUser(username);
				if(gesture_password.equals(user.getGesturepassword_flag())){
					resultMap.put("user_id", user.getUser_id());
					resultMap.put("id_card", user.getId_card());
					resultMap.put("user_name", user.getUser_name());
					resultMap.put("phone", user.getPhone());
					resultMap.put("nick_name", user.getNick_name());
					System.out.println("session=============="+session.getId());
					//登录成功，将用户信息存入session
					session.setAttribute(Constant.SESSION_USER, user);
					result=true;
				}else{
					errInfo="密码错误";
				}
			}else{//密码登陆
				User user=userService.getUser(username);
				if(password.equals(user.getPassword())){
					resultMap.put("user_id", user.getUser_id());
					resultMap.put("id_card", user.getId_card());
					resultMap.put("user_name", user.getUser_name());
					resultMap.put("phone", user.getPhone());
					resultMap.put("nick_name", user.getNick_name());
					System.out.println("session=============="+session.getId());
					//登录成功，将用户信息存入session
					session.setAttribute(Constant.SESSION_USER, user);
					result=true;
				}else{
					errInfo="密码错误";
				}
			}
		} 

        if(result){ 
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_SUCCESS);
		}else{
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_ERROR);
			resultMap.put(Constant.RETURN_MSG, errInfo);
		}
		return resultMap;

	}
	
	/**
	 * Method name 修改密码
	 * @param username
	 * @param password
	 * @param newpassword
	 * @param gesture_password
	 * @param loginmode
	 * @return
	 */
	@RequestMapping(value="/pwdupdate",method=RequestMethod.POST)
	@ResponseBody
	public Map loginPWDUpdate(String username,String password,String newpassword,String gesture_password,String loginmode){
		Map resultMap = new HashMap();  
		BufferedReader reader;
		boolean result = false;
		String errInfo = "";
		String content="";
		
		System.out.println("session--------------------------"+session.getAttribute("sessionUser"));
		session.setAttribute("UserId", "UserId");
		System.out.println("username--------------------------"+username);
		System.out.println("password--------------------------"+password);
		System.out.println("gesture_password--------------------------"+gesture_password);
		System.out.println("loginmode--------------------------"+loginmode);//登陆方式：F(手势登录) P(密码登陆);
		boolean status=userService.getCount(username);
		if(!status){
			errInfo="该用户名不存在";
		}else{
			if("F".equals(loginmode)){//手势登陆
				User user=userService.getUser(username);
				if(gesture_password.equals(user.getGesturepassword_flag())){
					user.setGesture_password(newpassword);
					result=userService.updateUser(user);
					
				}else{
					errInfo="原密码错误";
				}
			}else{//密码登陆
				User user=userService.getUser(username);
				if(password.equals(user.getPassword())){
					user.setPassword(newpassword);
					result=userService.updateUser(user);
					System.out.println("session=============="+session.getId());

				}else{
					errInfo="原密码错误";
				}
			}
		} 

        if(result){ 
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_SUCCESS);
		}else{
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_ERROR);
			resultMap.put(Constant.RETURN_MSG, errInfo);
		}
		return resultMap;

	}
	/**
	 * 注册
	 * @return
	 */
	@RequestMapping(value="/registereduser",method=RequestMethod.POST)
	@ResponseBody
	public Map registereduser(String user_name,String id_card,String phone,String nick_name,String password,String gesture_password,String gesturepassword_flag){
		Map resultMap = new HashMap();  
		BufferedReader reader;
		boolean result = false;
		String errInfo = "";
		String content="";
		String user_id=null;
		System.out.println("session--------------------------"+session.getAttribute("User"));
		User user= new User();
		user.setGesture_password(gesture_password);
		user.setGesturepassword_flag(gesturepassword_flag);
		user.setId_card(id_card);
		user.setNick_name(nick_name);
		user.setPassword(password);
		user.setPhone(phone);
		user.setUser_id(user_id); 
		user.setUser_name(user_name);
		if(!userService.getId_cardCount(user)){
			if(!userService.getNick_nameCount(user)){
				if(!userService.getPhoneCount(user)){
					result=userService.insertUser(user);
					if(!result){
						errInfo="注册失败，请稍后再试";
					}
				}else{
					errInfo="手机号已被使用";
				}
			}else{
				errInfo="昵称已被使用";
			}
		}else{
			errInfo="该身份证已注册";
		}
		
        if(result){ 
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_SUCCESS);
		}else{
			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_ERROR);
			resultMap.put(Constant.RETURN_MSG, errInfo);
		}
		return resultMap;

	}
	
	/**
	 * 将Map的值映射到对象里
	 * @return been
	 * @throws ValidationException 
	 */
	@SuppressWarnings("unused")
	private Object  mappingTobeen(Object bean,Map<String,String> map) throws ValidationException{
		try {
			BeanUtilsBean.getInstance().populate(bean, map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
//			throw new ValidationException("Map---to---been转换错误"); 
			e.printStackTrace();
		} 
		return bean;
	}
	/**
	 * 请求登录，验证用户
	 * @param session
	 * @param loginname
	 * @param password
	 * @param code
	 * @return
	 */
//	@RequestMapping(value="/login",method=RequestMethod.POST)
//	@ResponseBody
//	public Map loginPost(String loginname,String password,String code) {
//		Map resultMap = new HashMap();
//		boolean result = false;
//		String errInfo = "";
//		
//		String requestHeader = request.getHeader("user-agent"); //检测是电脑还是手机
//		if(Constant.isMobileDevice(requestHeader)){
//			//手机设备
//			User3 user = userService.getUserByNameAndPwd(loginname, password);
//			if(user!=null){
//				user.setLastLogin(new Date());
//				userService.updateLastLogin(user);
//				System.out.println("session=============="+session.getId());
//				//登录成功，将用户信息存入session
//				session.setAttribute(Constant.SESSION_USER, user);
//				result = true;//校验成功
//			}else{
//				errInfo = "用户名或密码有误！";
//			}
//		}else{
//			//电脑设备
//			//验证短信验证码
//			if(Tools.isEmpty(code)){
//				errInfo = "验证码不能为空！！";
//			}else{
//				System.out.println("session=============="+session.getSessionContext());
//				String sessionCode = (String)session.getAttribute(Constant.SESSION_SECURITY_CODE);
//				if(!sessionCode.equalsIgnoreCase(code)){
//					errInfo = "验证码输入有误！";
//				}else{
//					session.removeAttribute(Constant.SESSION_SECURITY_CODE);
//					//校验用户名密码
//					User3 user = userService.getUserByNameAndPwd(loginname, password);
//					if(user!=null){
//						user.setLastLogin(new Date());
//						userService.updateLastLogin(user);
//						//登录成功，将用户信息存入session
//						session.setAttribute(Constant.SESSION_USER, user);
//						result = true;//校验成功
//					}else{
//						errInfo = "用户名或密码有误！";
//					}
//				}
//			}
//		}
//		if(result){
////			initPicPath2();//登录成功，初始化图片路径参数
//			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_SUCCESS);
//		}else{
//			resultMap.put(Constant.RETURN_CODE, Constant.NORMAL_ERROR);
//			resultMap.put(Constant.RETURN_MSG, errInfo);
//		}
//		
//		
//		
//		
//		return resultMap;
//	}
	
	/**
	 * @description:初始化登录成功界面 
	 * @return：
	 */
	@RequestMapping("/forLogin")
	public ModelAndView forLogin(){
		ModelAndView mv=new ModelAndView("/index.do");
		try{
			User user= (User) session.getAttribute(Constant.SESSION_USER);
			if(user!=null){
				mv.setViewName("redirect:/index.do");
			}else{
				mv.addObject("errorInfo", "登录超时，请重新登录");
			}

		}catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

//	
//	/**
//	 * 访问系统首页
//	 * @param session
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value="/index")
//	public String index(HttpSession session,Model model){
//		User user = (User)session.getAttribute(Constant.SESSION_USER);
//		user = userService.getUserAndRoleById(user.getUserId());
//		Role role = user.getRole();
//		String roleRights = role!=null ? role.getRights() : "";
//		String userRights = user.getRights();
//		//避免每次拦截用户操作时查询数据库，以下将用户所属角色权限、用户权限限都存入session
//		session.setAttribute(Constant.SESSION_ROLE_RIGHTS, roleRights); //将角色权限存入session
//		session.setAttribute(Constant.SESSION_USER_RIGHTS, userRights); //将用户权限存入session
//		
//		List<Menu> menuList = menuService.listAllMenu();
//		
//		if(Tools.notEmpty(userRights) || Tools.notEmpty(roleRights)){
//			for(Menu menu : menuList){
//				menu.setHasMenu(RightsHelper.testRights(userRights, menu.getMenuId()) || RightsHelper.testRights(roleRights, menu.getMenuId()));
//				if(menu.isHasMenu()){
//					List<Menu> subMenuList = menu.getSubMenu();
//					for(Menu sub : subMenuList){
//						sub.setHasMenu(RightsHelper.testRights(userRights, sub.getMenuId()) || RightsHelper.testRights(roleRights, sub.getMenuId()));
//					}
//				}
//			}
//		}
//		model.addAttribute("user", user);
//		model.addAttribute("menuList", menuList);
//		Constant.print(JSON.toJSONString(menuList));
//		return "index";
//	}
//	
//	/**
//	 * 进入首页后的默认页面
//	 * @return
//	 */
//	@RequestMapping(value="/default")
//	public String defaultPage(){
//		return "default";
//	}
	
	/**
	 * 用户注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout")
	public String logout(HttpSession session){
		session.removeAttribute(Constant.SESSION_USER);
		session.removeAttribute(Constant.SESSION_ROLE_RIGHTS);
		session.removeAttribute(Constant.SESSION_USER_RIGHTS);
		return "login";
	}
	public static void main(String[] args) {
//		Map map=new HashMap();
//		map.put("channel", "1111111111111");
////		EventInformation a= new EventInformation();
//		try {
//			BeanUtilsBean.getInstance().populate(a, map);
//		} catch (IllegalAccessException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (InvocationTargetException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(a.getChannel());
//		System.out.println(a.getChannel());
	}
}
