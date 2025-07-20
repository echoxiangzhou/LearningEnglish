from flask import current_app
from flask_mail import Message
from app import mail
import logging
from threading import Thread

logger = logging.getLogger(__name__)

def send_async_email(app, msg):
    """Send email asynchronously"""
    with app.app_context():
        try:
            mail.send(msg)
            logger.info(f"Email sent successfully to {msg.recipients}")
        except Exception as e:
            logger.error(f"Failed to send email to {msg.recipients}: {str(e)}")

def send_email(to, subject, template, **kwargs):
    """Send email with error handling"""
    try:
        if not current_app.config.get('MAIL_USERNAME'):
            logger.warning("Email sending disabled: MAIL_USERNAME not configured")
            return False
            
        msg = Message(
            subject=subject,
            recipients=[to] if isinstance(to, str) else to,
            html=template,
            sender=current_app.config['MAIL_DEFAULT_SENDER']
        )
        
        # Send email asynchronously
        Thread(target=send_async_email, args=(current_app._get_current_object(), msg)).start()
        return True
        
    except Exception as e:
        logger.error(f"Failed to prepare email for {to}: {str(e)}")
        return False

def send_verification_email(user_email, verification_code, username):
    """Send email verification code to user"""
    subject = "验证您的邮箱地址 - English Learning Platform"
    
    html_template = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>邮箱验证</title>
        <style>
            body {{
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
                line-height: 1.6;
                color: #333;
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f5f5f5;
            }}
            .container {{
                background-color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }}
            .header {{
                text-align: center;
                margin-bottom: 30px;
            }}
            .logo {{
                font-size: 24px;
                font-weight: bold;
                color: #2563eb;
                margin-bottom: 10px;
            }}
            .verification-code {{
                background-color: #f8fafc;
                border: 2px dashed #e2e8f0;
                padding: 20px;
                text-align: center;
                margin: 30px 0;
                border-radius: 8px;
            }}
            .code {{
                font-size: 32px;
                font-weight: bold;
                color: #2563eb;
                letter-spacing: 4px;
                font-family: 'Courier New', monospace;
            }}
            .footer {{
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #e2e8f0;
                font-size: 14px;
                color: #64748b;
                text-align: center;
            }}
            .warning {{
                background-color: #fef3c7;
                border-left: 4px solid #f59e0b;
                padding: 15px;
                margin: 20px 0;
                border-radius: 4px;
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="logo">English Learning Platform</div>
                <h1>邮箱验证</h1>
            </div>
            
            <p>亲爱的 <strong>{username}</strong>，</p>
            
            <p>感谢您注册 English Learning Platform！为了确保您的账户安全，请使用以下验证码完成邮箱验证：</p>
            
            <div class="verification-code">
                <div>您的验证码是：</div>
                <div class="code">{verification_code}</div>
            </div>
            
            <div class="warning">
                <strong>重要提示：</strong>
                <ul style="margin: 10px 0; padding-left: 20px;">
                    <li>此验证码仅在 <strong>10 分钟</strong> 内有效</li>
                    <li>请勿将验证码透露给他人</li>
                    <li>如果您没有注册账户，请忽略此邮件</li>
                </ul>
            </div>
            
            <p>如果您有任何问题，请联系我们的客服团队。</p>
            
            <p>祝您学习愉快！<br>
            English Learning Platform 团队</p>
            
            <div class="footer">
                <p>此邮件由系统自动发送，请勿回复。</p>
                <p>如果您没有注册我们的服务，请忽略此邮件。</p>
            </div>
        </div>
    </body>
    </html>
    """
    
    return send_email(user_email, subject, html_template)

def send_password_reset_email(user_email, reset_token, username):
    """Send password reset email to user"""
    subject = "重置您的密码 - English Learning Platform"
    
    # TODO: Implement password reset email template
    html_template = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>密码重置</title>
    </head>
    <body>
        <h2>密码重置请求</h2>
        <p>亲爱的 {username}，</p>
        <p>我们收到了您的密码重置请求。请点击以下链接重置您的密码：</p>
        <p><a href="#">重置密码链接（待实现）</a></p>
        <p>如果您没有请求重置密码，请忽略此邮件。</p>
        <p>此链接将在 30 分钟后失效。</p>
    </body>
    </html>
    """
    
    return send_email(user_email, subject, html_template)