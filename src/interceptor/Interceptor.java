package interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class Interceptor extends AbstractInterceptor{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invoker) throws Exception {
		Object admin = ActionContext.getContext().getSession().get("admin");  
		 Object student = ActionContext.getContext().getSession().get("studentInfo");  
	        if(null == admin && student == null){  
	        	return "login";  // 这里返回用户登录页面视图  
	        }else {
	        	return invoker.invoke(); 
	        }
	}

}
