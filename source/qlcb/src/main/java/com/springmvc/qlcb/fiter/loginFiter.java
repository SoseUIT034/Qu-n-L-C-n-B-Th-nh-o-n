package com.springmvc.qlcb.fiter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.springmvc.qlcb.model.Taikhoan;


public class loginFiter implements Filter{
	FilterConfig filterConfig = null;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		
		HttpServletRequest r = (HttpServletRequest)arg0;
		HttpSession session = r.getSession();
		
		Taikhoan tk= (Taikhoan) session.getAttribute("loggedInUser");
		
		if(tk!=null)
		{
			HttpServletRequest res1=  ((HttpServletRequest) arg0);
			HttpServletResponse res=  ((HttpServletResponse) arg1);
			
			arg2.doFilter(res1, res);
		}
		else
		{
			
			
			if (!r.getRequestURI().matches("((!?index)(.*)\\.xhtml)|((.*)\\.(png|gif|jpg|css|js(\\.xhtml)?))"))
			{
				 
			
			HttpServletResponse res=  ((HttpServletResponse) arg1);
			 r.getRequestDispatcher("/login").forward(arg0, res);
			 
		        return;
			
			}
			else
			{

				HttpServletRequest res1=  ((HttpServletRequest) arg0);
				HttpServletResponse res=  ((HttpServletResponse) arg1);
				
				arg2.doFilter(res1, res);
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		this.filterConfig = arg0;
		
		
	}

}
