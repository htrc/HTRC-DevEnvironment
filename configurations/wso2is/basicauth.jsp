<%--
  ~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@ page import="org.apache.cxf.jaxrs.client.JAXRSClientFactory" %>
<%@ page import="org.apache.cxf.jaxrs.provider.json.JSONProvider" %>
<%@ page import="org.apache.http.HttpStatus" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.client.SelfUserRegistrationResource" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityUtil" %>
<%@ page import="javax.ws.rs.core.Response" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.bean.ResendCodeRequestDTO" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.bean.UserDTO" %>

<div class="login-page">
  <div class="form">
  <!-- <div class="htrc-logo"><img src="images/htrc-logo.png" width="100"></div> -->
  <h3>Sign In to <span class="htrc-text">HathiTrust Research Center</span></h3>
<%
    String resendUsername = request.getParameter("resend_username");
    if (StringUtils.isNotBlank(resendUsername)) {

        String url = config.getServletContext().getInitParameter(Constants.ACCOUNT_RECOVERY_REST_ENDPOINT_URL);

        ResendCodeRequestDTO selfRegistrationRequest = new ResendCodeRequestDTO();
        UserDTO userDTO = AuthenticationEndpointUtil.getUser(resendUsername);
        selfRegistrationRequest.setUser(userDTO);
        url = url.replace("tenant-domain", userDTO.getTenantDomain());

        List<JSONProvider> providers = new ArrayList<JSONProvider>();
        JSONProvider jsonProvider = new JSONProvider();
        jsonProvider.setDropRootElement(true);
        jsonProvider.setIgnoreNamespaces(true);
        jsonProvider.setValidateOutput(true);
        jsonProvider.setSupportUnwrapped(true);
        providers.add(jsonProvider);

        SelfUserRegistrationResource selfUserRegistrationResource = JAXRSClientFactory
                .create(url, SelfUserRegistrationResource.class, providers);
        Response selfRegistrationResponse = selfUserRegistrationResource.regenerateCode(selfRegistrationRequest);
        if (selfRegistrationResponse != null &&  selfRegistrationResponse.getStatus() == HttpStatus.SC_CREATED) {
%>
<div class="alert alert-info"><%= Encode.forHtml(resourceBundle.getString(Constants.ACCOUNT_RESEND_SUCCESS_RESOURCE)) %>
</div>
<%
} else {
%>
<div class="alert alert-danger"><%= Encode.forHtml(resourceBundle.getString(Constants.ACCOUNT_RESEND_FAIL_RESOURCE))  %>
</div>
<%
        }
    }

    String type = request.getParameter("type");
    if ("samlsso".equals(type)) {
%>
<form action="/samlsso" method="post" id="loginForm" class="login-form">
    <input id="tocommonauth" name="tocommonauth" type="hidden" value="true">
<%
    } else if ("oauth2".equals(type)){
%>
    <form action="/oauth2/authorize" method="post" id="loginForm" class="login-form">
        <input id="tocommonauth" name="tocommonauth" type="hidden" value="true">

<%
    } else {
%>
<form action="../commonauth" method="post" id="loginForm" class="login-form">

    <%
        }
    %>

    <% if (Boolean.parseBoolean(loginFailed)) { %>
    <div class="alert alert-danger" id="error-msg"><%= Encode.forHtml(errorMessage) %>
    </div>
    <%}else if((Boolean.TRUE.toString()).equals(request.getParameter("authz_failure"))){%>
    <div class="alert alert-danger" id="error-msg">You are not authorized to login
    </div>
    <%}%>
    <input id="username" name="username" type="text" placeholder="Username"/>
      <input id="password" name="password" type="password" placeholder="Password" autocomplete="off"/>
        <input type="hidden" name="sessionDataKey" value='<%=Encode.forHtmlAttribute
            (request.getParameter("sessionDataKey"))%>'/>
    <%
        if (reCaptchaEnabled) {
    %>
    <div class="form-group">
        <div class="g-recaptcha"
             data-sitekey="<%=Encode.forHtmlContent(request.getParameter("reCaptchaKey"))%>">
        </div>
    </div>
    <%
        }
    %>
        <!-- <div class="checkbox">
            <input type="checkbox" id="chkRemember" name="chkRemember">
            <label for="chkRemember">Remember me on this computer</label>
        </div> -->
        <label class="control control--checkbox">Remember me on this computer<input type="checkbox" name="chkRemember"/><div class="control__indicator"></div>
        </label>
        <br>

                  <button type="submit">Sign In</button>
<%
String iec =
        application.getInitParameter("IdentityManagementEndpointContextURL");
if (StringUtils.isBlank(iec)) {
    iec = IdentityUtil.getServerURL("/accountrecoveryendpoint", true, true);
}
%>
    <div class="link-group">
      <%=iec%>
        <%

            String scheme = request.getScheme();
            String serverName = request.getServerName();
            int serverPort = request.getServerPort();
            String uri = (String) request.getAttribute("javax.servlet.forward.request_uri");
            String prmstr = (String) request.getAttribute("javax.servlet.forward.query_string");
            String urlWithoutEncoding = scheme + "://" +serverName + ":" + serverPort + uri + "?" + prmstr;
            String urlEncodedURL = URLEncoder.encode(urlWithoutEncoding, "UTF-8");

            if (request.getParameter("relyingParty").equals("wso2.my.dashboard")) {
                String identityMgtEndpointContext =
                        application.getInitParameter("IdentityManagementEndpointContextURL");
                if (StringUtils.isBlank(identityMgtEndpointContext)) {
                    identityMgtEndpointContext = IdentityUtil.getServerURL("/accountrecoveryendpoint", true, true);
                }


                URL url = null;
                HttpURLConnection httpURLConnection = null;

                url = new URL(identityMgtEndpointContext + "/recoverpassword.do?callback="+Encode.forHtmlAttribute
                        (urlEncodedURL ));
                httpURLConnection = (HttpURLConnection) url.openConnection();
                httpURLConnection.setRequestMethod("HEAD");
                httpURLConnection.connect();
                if (httpURLConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
        %>
        <a id="passwordRecoverLink" href="<%=url%>">Forgot Password</a>
    <%
        }

        url = new URL(identityMgtEndpointContext + "/recoverusername.do?callback="+Encode.forHtmlAttribute
                (urlEncodedURL ));
        httpURLConnection = (HttpURLConnection) url.openConnection();
        httpURLConnection.setRequestMethod("HEAD");
        httpURLConnection.connect();
        if (httpURLConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
    %>
         | <a id="usernameRecoverLink" href="<%=url%>">Forgot Username</a>
    <%
        }

            }
         if (Boolean.parseBoolean(loginFailed) && errorCode.equals(IdentityCoreConstants.USER_ACCOUNT_NOT_CONFIRMED_ERROR_CODE) && request.getParameter("resend_username") == null) { %>

         | <a id="registerLink" href="login.do?resend_username=<%=Encode.forHtml(request.getParameter("failedUsername"))%>&<%=AuthenticationEndpointUtil.cleanErrorMessages(request.getQueryString())%>">Re-Send Confirmation E-mail</a>

        <%}%>
    </div>
</form>
</div>
</div>
