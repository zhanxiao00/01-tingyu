package com.bjsxt.test;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

public class TestCode {
    public static void main(String[] args) {
        // 代码生成器
             AutoGenerator mpg = new AutoGenerator();
        //全局配置策略
            GlobalConfig gc = new GlobalConfig();
            String path = System.getProperty("user.dir");//动态获取当前项目的路径
            System.out.println(path);
            gc.setFileOverride(true);// 是否覆盖同名文件，默认是false
            gc.setActiveRecord(true);// 不需要ActiveRecord特性的请改为false
            gc.setEnableCache(false);// XML 二级缓存
            gc.setBaseResultMap(true);// XML ResultMap
            gc.setBaseColumnList(false);// XML columList
            gc.setOutputDir(path+"/01-tingyu/src");
            gc.setIdType(IdType.AUTO);//设置主键策略

        //数据源配置
            DataSourceConfig dsc = new DataSourceConfig();
            dsc.setUrl("jdbc:mysql://localhost:3306/01-tingyu?useUnicode=true&useSSL=false&characterEncoding=utf8");
            // dsc.setSchemaName("public");
            dsc.setDriverName("com.mysql.jdbc.Driver");
            dsc.setUsername("root");
            dsc.setPassword("root");

        // 包配置
            PackageConfig pc = new PackageConfig();
            pc.setParent("com.bjsxt")
                    .setMapper("mapper")
                    .setService("service")
                    .setController("controller")
                    .setEntity("pojo")
                    .setXml("mapper");
        //策略配置
            /**
             * t_admin
             * t_admin_role
             * t_company
             * t_host
             * t_host_power
             * t_married_person
             * t_menu
             * t_order
             * t_planner
             * t_role
             * t_role_menu
             */
            StrategyConfig stConfig = new StrategyConfig();
            stConfig.setCapitalMode(true) //全局大写命名
                    .setNaming(NamingStrategy.underline_to_camel) // 数据库表映射到实体的命名策略
                    .setTablePrefix("t_")
                    .setInclude("t_admin","t_admin_role","t_company","t_host","t_host_power",
                            "t_married_person","t_menu","t_order","t_planner","t_role","t_role_menu"); // 生成的表，多个表继续传递即可，String类型的可变参数
        //将策略配置对象集成到代码生成器中
            mpg.setGlobalConfig(gc);
            mpg.setDataSource(dsc);
            mpg.setPackageInfo(pc);
            mpg.setStrategy(stConfig);
            //执行生成
            mpg.execute();
    }
}
