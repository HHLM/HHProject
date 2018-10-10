#!/bin/bash
########################
# 脚本功能：类重命名脚本
# 输入参数 -i 输入的文件夹
# 输入参数 -o 保存的文件
########################


####### 配置
# 定义需要替换的类的查找目录，作为参数传递给GenRenameClasses.sh脚本使用，最终获取到的类名称保存到配置文件中，以给后续步骤使用
class_search_dir="$(pwd)/../HHClock/Business"
# class_search_dir="$(pwd)/../injectedContentKit/Business"
# class_search_dir="/Users/aron/PuTaoWorkSpace/project/sscatch/sscatch/Classes/Business"
# 配置文件
cfg_file="$(pwd)/configures/RenameClasses.cfg"

# project.pbxproj文件目录，需要替换该配置文件中的类的名称配置
pbxproj_dir="$(pwd)/../HHClock.xcodeproj"
# pbxproj_dir="$(pwd)/../InjectedContentKit.xcodeproj"
# pbxproj_dir="/Users/aron/PuTaoWorkSpace/project/sscatch/sscatch.xcodeproj"

# 定义该目录下的文件需要进行批量替换处理
class_name_replace_dir="$(pwd)/../HHClock"
# class_name_replace_dir="$(pwd)/../InjectedContentKit"
# class_name_replace_dir="/Users/aron/PuTaoWorkSpace/project/sscatch/sscatch/Classes/Business"

# 定义该目录下的文件需要进行批量替换处理
# class_name_replace_support_dir="$(pwd)/../InjectedContentKit000"
# # class_name_replace_support_dir="$(pwd)/../InjectedContentKit"
# class_name_replace_support_dir="/Users/aron/PuTaoWorkSpace/project/sscatch/sscatch/SupportingFiles"

# 
trash_classes_cfg_file="$(pwd)/configures/TrashClass.cfg"

declare -a original_class_array
declare -a replaced_class_array
class_number_count=0

# 类前缀
class_prefix="XYZ"
# 类后缀
class_suffix="ABC"


####### 配置检查处理

# 导入工具脚本
. ./FileUtil.sh
. ./EnvCheckUtil.sh
. ./StringUtil.sh

# 检测 class_search_dir
checkDirCore $class_search_dir "指定类的查找目录不存在"
class_search_dir=${CheckInputDestDirRecursiveReturnValue} 

# 检测 pbxproj_dir
checkDirCore $pbxproj_dir "指定项目配置目录（pbxproj所在的目录，一般是 xxx.xcodeproj）不存在"
pbxproj_dir=${CheckInputDestDirRecursiveReturnValue}

# 检测 class_name_replace_dir
checkDirCore $class_name_replace_dir "指定类名称修改的目录不存在"
class_name_replace_dir=${CheckInputDestDirRecursiveReturnValue}

# 检测 class_name_replace_support_dir
# checkDirCore $class_name_replace_support_dir "指定类名称修改的目录不存在"
# class_name_replace_support_dir=${CheckInputDestDirRecursiveReturnValue}


# 检测或者创建配置文件
checkOrCreateFile $cfg_file


# 检测gun sed
gunSedInstallCheck


####### 数据定义
# 定义保存类名称的数组
declare -a config_content_array
cfg_line_count=0

# 1、读取配置文件内容保存到数组中
read_config_content_to_array() {
	# 读取配置文件
	echo "开始读取配置文件..."
	# mark: p291
	IFS_OLD=$IFS
	IFS=$'\n'
	# 删除文件行首的空白字符 http://www.jb51.net/article/57972.htm
	for line in $(cat $cfg_file | sed 's/^[ \t]*//g')
	do
		is_comment=$(expr "$line" : '^#.*')
		echo "line=${line} is_common=${is_comment}"
		if [[ ${#line} -eq 0 ]] || [[ $(expr "$line" : '^#.*') -gt 0 ]]; then
			echo "blank line or comment line"
		else
			config_content_array[$cfg_line_count]=$line
			cfg_line_count=$[ $cfg_line_count + 1 ]
			echo "line>>>>${line}"
		fi	
	done
	IFS=${IFS_OLD}

	for (( i = 0; i < ${#config_content_array[@]}; i++ )); do
		config_content=${config_content_array[i]};
		echo "config_content>>>>>>${config_content}"
	done
}


# 2、根据规则修改类名
function add_prefix_suffix_to_class {
	# 2.1、类添加前缀和后缀
	for (( i = 0; i < ${#config_content_array[@]}; i++ )); do

		# 随机的前缀和后缀
		class_prefix=`randstr`
		class_suffix=`randstr`

		original_class_name=${config_content_array[i]};
		result_class_name="${class_prefix}${original_class_name}${class_suffix}"

		# 保存修改前和修改后的类名 rename_class_file 这一步要使用到
		original_class_array[$class_number_count]=${original_class_name}
		replaced_class_array[$class_number_count]=${result_class_name}
		class_number_count=$[ class_number_count + 1 ];

		sed -i '{
			s/'"${original_class_name}"'/'"${result_class_name}"'/g
		}' `grep ${original_class_name} -rl ${pbxproj_dir}`
		sed -i '{
			s/'"${original_class_name}"'/'"${result_class_name}"'/g
		}' `grep ${original_class_name} -rl ${class_name_replace_dir}`

		# sed -i '{
		# 	s/'"${original_class_name}"'/'"${result_class_name}"'/g
		# }' `grep ${original_class_name} -rl ${class_name_replace_support_dir}`

		echo "正在处理类 ${original_class_name}..."
	done
}

# 3、修改类的文件名称
function rename_class_file {
	echo "" > ${trash_classes_cfg_file}
	echo "class_name_replace_dir >> ${class_name_replace_dir}"
	for (( i = 0; i < ${#original_class_array[@]}; i++ )); do

		original_class_name=${original_class_array[i]};
		result_class_name=${replaced_class_array[i]};

		# .h 文件
		pattern="${original_class_name}\.h"
		find_result=$(find ${class_name_replace_dir} -name ${pattern})
		new_file_path=${find_result/$original_class_name/$result_class_name}
		echo "find_result = ${find_result}"
		echo "new_file_path = ${new_file_path}"
		mv -f $find_result $new_file_path
		echo ${new_file_path} >> ${trash_classes_cfg_file}

		# .m 文件
		pattern="${original_class_name}\.m"
		find_result=$(find ${class_name_replace_dir} -name ${pattern})
		new_file_path=${find_result/$original_class_name/$result_class_name}
		echo "find_result = ${find_result}"
		echo "new_file_path = ${new_file_path}"
		mv -f $find_result $new_file_path
		echo ${new_file_path} >> ${trash_classes_cfg_file}

		# .xib 文件
		pattern="${original_class_name}\.xib"
		find_result=$(find ${class_name_replace_dir} -name ${pattern})
		new_file_path=${find_result/$original_class_name/$result_class_name}
		echo "find_result = ${find_result}"
		echo "new_file_path = ${new_file_path}"
		mv -f $find_result $new_file_path
		echo ${new_file_path} >> ${trash_classes_cfg_file}

	done
}

# 获取需要重命名的类名称，保存到配置文件中
./GetAndStoreClasses.sh\
	-i ${class_search_dir}\
	-o ${cfg_file}

# 读取配置文件内容保存到数组中
read_config_content_to_array
# 类名以及引用添加前缀和后缀
add_prefix_suffix_to_class
# 修改类文件名字
rename_class_file

echo "批量重命名类名完成。"

