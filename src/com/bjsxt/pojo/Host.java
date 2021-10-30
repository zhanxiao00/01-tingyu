package com.bjsxt.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
@TableName("t_host")
public class Host extends Model<Host> {

    private static final long serialVersionUID=1L;

    @TableId(value = "hid", type = IdType.AUTO)
    private Integer hid;

    private String hname;

    private String hpwd;

    private String hphone;

    private LocalDateTime starttime;

    private String status;

    private String strong;

    private Integer ordernumber;

    @Setter
    @Getter
    @TableField(exist=false)
    private HostPower hostPower;


    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public String getHpwd() {
        return hpwd;
    }

    public void setHpwd(String hpwd) {
        this.hpwd = hpwd;
    }

    public String getHphone() {
        return hphone;
    }

    public void setHphone(String hphone) {
        this.hphone = hphone;
    }

    public LocalDateTime getStarttime() {
        return starttime;
    }

    public void setStarttime(LocalDateTime starttime) {
        this.starttime = starttime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStrong() {
        return strong;
    }

    public void setStrong(String strong) {
        this.strong = strong;
    }

    public Integer getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(Integer ordernumber) {
        this.ordernumber = ordernumber;
    }

    @Override
    protected Serializable pkVal() {
        return this.hid;
    }

    @Override
    public String toString() {
        return "Host{" +
        "hid=" + hid +
        ", hname=" + hname +
        ", hpwd=" + hpwd +
        ", hphone=" + hphone +
        ", starttime=" + starttime +
        ", status=" + status +
        ", strong=" + strong +
        ", ordernumber=" + ordernumber +
        "}";
    }
}
