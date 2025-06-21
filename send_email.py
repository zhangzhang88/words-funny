import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.header import Header
import ssl

def send_email_163(sender_email, auth_code, receiver_email, subject, content):
    """
    使用163邮箱发送邮件
    :param sender_email: 发件人邮箱
    :param auth_code: 授权码
    :param receiver_email: 收件人邮箱
    :param subject: 邮件主题
    :param content: 邮件内容
    """
    # 163邮箱SMTP服务器设置
    smtp_server = "smtp.163.com"
    smtp_port = 465  # 使用SSL加密端口

    # 创建邮件对象
    message = MIMEMultipart()
    message['From'] = Header(sender_email)
    message['To'] = Header(receiver_email)
    message['Subject'] = Header(subject)

    # 添加邮件内容
    message.attach(MIMEText(content, 'plain', 'utf-8'))

    try:
        print("正在连接SMTP服务器...")
        # 创建SSL上下文
        context = ssl.create_default_context()
        
        # 连接SMTP服务器（使用SSL加密）
        server = smtplib.SMTP_SSL(smtp_server, smtp_port, context=context)
        print("SMTP服务器连接成功！")
        
        # 设置调试级别
        server.set_debuglevel(1)
        
        print("正在尝试登录...")
        # 登录
        server.login(sender_email, auth_code)
        print("登录成功！")
        
        # 发送邮件
        print("正在发送邮件...")
        server.sendmail(sender_email, receiver_email, message.as_string())
        print("邮件发送成功！")
        
    except smtplib.SMTPAuthenticationError as e:
        print(f"认证失败：{str(e)}")
        print("请检查：")
        print("1. 授权码是否正确")
        print("2. 是否已在163邮箱设置中开启SMTP服务")
        print("3. 授权码是否已过期")
    except smtplib.SMTPException as e:
        print(f"SMTP错误：{str(e)}")
    except Exception as e:
        print(f"发生错误：{str(e)}")
    finally:
        try:
            server.quit()
            print("SMTP连接已关闭")
        except:
            pass

if __name__ == "__main__":
    # 邮件配置
    sender_email = "worldshijiebo@163.com"
    auth_code = "ZSxsNYYpwHXQckfS"
    receiver_email = "worldshijiebo@163.com"  # 发送给自己测试
    
    # 设置邮件主题和内容
    subject = "测试邮件"
    content = """
    您好！

    这是一封测试邮件，用于验证SMTP配置是否正确。

    如果收到此邮件，说明SMTP配置成功！
    """

    # 发送邮件
    send_email_163(sender_email, auth_code, receiver_email, subject, content)