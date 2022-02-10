#!/bin/bash
_SCRIPT="${0##*/}"

_usage_()
{
	cat >&1 <<USAGE
Usage: ${1} [-s] SOURCE [-o] OUTPUT [-c] COMMNAD [[-e] EXTENSION]
USAGE
}

_help_()
{
	cat >&1 <<HELP

Operation:
  -c, --command             command to execute
                            if the command with arguments, then you must enter
                            the command in quotes
  -f, --force               overwriting files without prompting for confirmation
  -s, --source=[DIR|FILE]   specify a directory or file to process
  -o, --output=[DIR|FILE]   specify output directory or file
  -e, --extension=EXT       specify the extension of the files for which the
                            specified command will be executed
                            if you set a file for processing with the '-s' key,
                            then this parameter will be applied to the output
                            file
Miscellaneous:
  -h,  -?, --help           display this help and exit

Report bugs to: bug-${1%%.*}@${2-megasam.ru}
${1} home page: <https://www.${2-megasam.ru}/shell-script/${1%%.*}/>
HELP
}

_parsing_arguments_()
{
	[ "${#}" -le 50 ] || return 21
	local _ARGUMENTS
	while [ "${#}" -gt 0 ]; do
		_ERROR="${1}"
		case "${1}" in
			""|-)
				return 23
				;;
			--)
				shift
				break
				;;
			-[?h]?*)
				_ARG="${1#??}"
				_KEY_H="${1%${_ARG}}"
				shift; set -- "-${_ARG}" "${@}"
				continue
				;;
			-[?h]|--help)
				_KEY_H="${1}"
				;;
			-с=*|--command=*)
				_ARG="${1#*=}"
				_KEY_C="${1%%=*}"
				shift; set -- "${_KEY_C}" "${_ARG}" "${@}"
				;;
			-c?*)
				_ARG="${1#??}"
				_KEY_C="${1%${_ARG}}"
				shift; set -- "${_KEY_C}" "${_ARG}" "${@}"
				;;
			-c|--command)
				_KEY_C="${1}"
				;;
			-f?*)
				_ARG="${1#??}"
				_KEY_F="${1%${_ARG}}"
				shift; set -- "-${_ARG}" "${@}"
				continue
				;;
			-f|--force)
				_KEY_F="${1}"
				;;
			-e=*|--extension=*)
				_ARG="${1#*=}"
				_KEY_E="${1%%=*}"
				shift; set -- "${_KEY_E}" "${_ARG}" "${@}"
				;;
			-e?*)
				_ARG="${1#??}"
				_KEY_E="${1%${_ARG}}"
				shift; set -- "${_KEY_E}" "${_ARG}" "${@}"
				;;
			-e|--extension)
				_KEY_E="${1}"
				;;
			-s=*|--source=*)
				_ARG="${1#*=}"
				_KEY_S="${1%%=*}"
				shift; set -- "${_KEY_S}" "${_ARG}" "${@}"
				;;
			-s?*)
				_ARG="${1#??}"
				_KEY_S="${1%${_ARG}}"
				shift; set -- "${_KEY_S}" "${_ARG}" "${@}"
				;;
			-s|--source)
				_KEY_S="${1}"
				;;
			-o=*|--output=*)
				_ARG="${1#*=}"
				_KEY_O="${1%%=*}"
				shift; set -- "${_KEY_O}" "${_ARG}" "${@}"
				;;
			-o?*)
				_ARG="${1#??}"
				_KEY_O="${1%${_ARG}}"
				shift; set -- "${_KEY_O}" "${_ARG}" "${@}"
				;;
			-o|--output)
				_KEY_O="${1}"
				;;
			-?*)
				return 23
				;;
			*)
				  if [ ! "${_SOURCE}" ]; then
					_SOURCE="${1}"
					_KEY_S="1"
				elif [ ! "${_OUTPUT}" ]; then
					_OUTPUT="${1}"
					_KEY_O="1"
				elif [ ! "${_COMMAND}" ]; then
					_COMMAND="${1}"
					_KEY_C="1"
				elif [ ! "${_EXT}" ]; then
					_EXT="${1}"
					_KEY_E="1"
				else
					return 23
				fi
				shift
				continue
				;;
		esac
		case "${2}" in ""|-*)
			_OPT="${1}"
			_ERROR="${2}"
			case "${1}" in
				"${_KEY_C}"|"${_KEY_S}"|"${_KEY_O}"|"${_KEY_E}") return 25 ;;
			esac ;;
		esac
		case "${1}" in
			"${_KEY_C}")
				shift
				_COMMAND="${1}"
				;;
			"${_KEY_S}")
				shift
				_SOURCE="${1}"
				;;
			"${_KEY_O}")
				shift
				_OUTPUT="${1}"
				;;
			"${_KEY_E}")
				shift
				_EXT="${1}"
				;;
		esac
		shift
	done
}

# BASH
_user_input_()
{
	while IFS= read -e -d $'\n' -p "${1}" _INPUT; do
		history -s $(sed -e "/^$/d" <<< "${_INPUT}") 2>/dev/null
		case "${_INPUT}" in
			([qQ])
				printf -- '%s\n' "${_SCRIPT}: execution canceled"
				exit 0
			;;
		esac
		[ "${2}" ] && {
			case "${_INPUT}" in
				"") [ "${2}" = "0" ] && return || return ;;
				[yY]|[yY][eE][sS]) return ;;
				[nN]|[nN][oO]) return 1 ;;
				[aA]) _YES_ALL="1"; return ;;
				[sS]) _NO_ALL="1"; return 1 ;;
			esac
		}
		[ "${_INPUT}" ] && break
	done < /dev/tty
}

# SH 
_check_write_permission_()
{
	[ "${1}" ] || return 20
	_PATH="${1%/}"
	while :; do
		[ -e "${_PATH}" ] && {
			[ -w "${_PATH}" ] && {
				[ -f "${_PATH}" ] || {
					[ -d "${_PATH}" ] && [ -x "${_PATH}" ] || return 77
				}
				return
			} || return 74
		}
		[ "${_PATH}" = "/" ] || {
			_PATH="${_PATH%/*}"
			[ "${_PATH}" ] || _PATH="/"
		}
	done
}

_which_()
{
	[ "${1}" ] || return 20
	_ERROR="${1}"
	_PROG=
	local IFS=':' _DIR
	for _DIR in ${PATH}; do
		[ -z "${_DIR}" ] && _DIR=.
		[ -f "${_DIR}/${1}" ] && {
			[ -x "${_DIR}/${1}" ] && {
				_PROG="${_DIR}/${1}"
				printf -- '%s\n' "${_PROG}"
				return
			}
			return 126
		}
	done
	return 31
}

_full_path_()
{
	local IFS="${IFS}"
	_PATH=
	case "${1}" in
		""   ) return 20 ;;
		\~   ) _PATH="${HOME}" ;;
		\~/* ) _PATH="${HOME}/${1#?}" ;;
		./*  ) [ "${PWD}" = "/" ] && _PATH="${1#?}" || _PATH="${PWD}${1#?}" ;;
		[!/]*) [ "${PWD}" = "/" ] && _PATH="/${1}"  || _PATH="${PWD}/${1}"  ;;
		*    ) _PATH="${1}" ;;
	esac
	[ "${_PATH}" = "/" ] || {
		IFS="/"
		set -- ${_PATH%/}
		_PATH=
		while [ ${#} -gt 0 ]; do
			case "${1}" in
				.|"") ;;
				..  ) _PATH="${_PATH%/*}"   ;;
				*   ) _PATH="${_PATH}/${1}" ;;
			esac
			shift
		done
	}
	_PATH="${_PATH-/}"
	printf -- '%s\n' "${_PATH}"
}

_parse_arguments_()
{
	while :; do
		[ "${_SOURCE}" ] || {
			printf -- '%s\n' "${_SCRIPT}: enter a directory or file to process, 'q' for out"
			_user_input_ "${_SCRIPT}: " || exit 0
			_SOURCE="${_INPUT}"
		}
		_SOURCE="`_full_path_ "${_SOURCE}"`" || {
			unset "_SOURCE"; continue
		}

		[ -e "${_SOURCE}" ] || {
			printf -- '%s\n' "${_SCRIPT}: error: no such file or directory -- '${_SOURCE}'" >&2
			unset "_SOURCE"; continue
		}
		[ -f "${_SOURCE}" ] || {
			if [ -d "${_SOURCE}" ]; then
				[ -x "${_SOURCE}" ] || {
					printf -- '%s\n' "${_SCRIPT}: error: no execute permissions -- '${_SOURCE}'" >&2
					unset "_SOURCE"; continue
				}
			else
				printf -- '%s\n' "${_SCRIPT}: error: not a file or directory -- '${_SOURCE}'" >&2
				unset "_SOURCE"; continue
			fi
		}
		[ -r "${_SOURCE}" ] || {
			printf -- '%s\n' "${_SCRIPT}: error: no read permissions -- '${_SOURCE}'" >&2
			unset "_SOURCE"; continue
		}
		# [ "${_KEY_S}" ] || {
		# 	printf -- '%s\n' "${_SCRIPT}: you set source -- '${_SOURCE}'" >&2
		# 	_user_input_ "${_SCRIPT}: continue? (Y/n): " "0" || {
		# 		unset "_SOURCE"; continue
		# 	}
		# }
		break
	done

	while :; do
		[ "${_OUTPUT}" ] || {
			printf -- '%s\n' "${_SCRIPT}: enter output directory or file, 'q' for out"
			_user_input_ "${_SCRIPT}: " || exit 0
			_OUTPUT="${_INPUT}"
		}
		_OUTPUT="`_full_path_ "${_OUTPUT}"`" || {
			unset "_OUTPUT"; continue
		}
		_check_write_permission_ "${_OUTPUT}" || {
			printf -- '%s\n' "${_SCRIPT}: checking write permissions for ${_OUTPUT}"
			printf -- '%s\n' "${_SCRIPT}: error: no write permissions -- '${_PATH}'" >&2
			unset "_OUTPUT"; continue
		}

		[ "${_OUTPUT}" = "${_SOURCE}" ] && {
			printf -- '%s\n' "${_SCRIPT}: error: coincidence of source and destination" >&2
			unset "_OUTPUT"; continue
		}

		# [ "${_KEY_O}" ] || {
		# 	printf -- '%s\n' "${_SCRIPT}: you set destination -- '${_OUTPUT}'" >&2
		# 	_user_input_ "${_SCRIPT}: continue? (Y/n): " "0" || {
		# 		unset "_OUTPUT"; continue
		# 	}
		# }
		break
	done

	while :; do
		[ "${_COMMAND}" ] || {
			printf -- '%s\n' "${_SCRIPT}: enter command to execute, 'q' for out"
			_user_input_ "${_SCRIPT}: " || exit 0
			_COMMAND="${_INPUT}"
		}
		# _COMMAND="/usr/bin/cp -v"
		_COM="`printf -- '%s\n' "${_COMMAND}" | awk '{print $1}'`"
		# _COM="/usr/bin/cp"
		# _which_ cp
		_which_ "${_COM##*/}" >/dev/null || {
			# _COM="./script"
			_COM="`_full_path_ "${_COM}"`"
			# _COM="/home/user/script"
			echo :"${_COM}":
			[ -f "${_COM}" ] || {
				printf -- '%s\n' "${_SCRIPT}: error: command not found -- '${_COM}'" >&2
				unset "_COMMAND"; continue
			}
			[ -x "${_COM}" ] || {
				printf -- '%s\n' "${_SCRIPT}: command is found but is not executable -- '${_COM}'" >&2
				unset "_COMMAND"; continue
			}
		}

		# [ "${_KEY_C}" ] || {
		# 	printf -- '%s\n' "${_SCRIPT}: command to execute -- '${_COMMAND}'" >&2
		# 	_user_input_ "${_SCRIPT}: continue? (Y/n): " "0" || {
		# 		unset "_COMMAND"; continue
		# 	}
		# }
		break
	done

	# while :; do
	# 	[ "${_EXT}" ] || {
	# 		printf -- '%s\n' "${_SCRIPT}: enter file extension, 'q' for out"
	# 		_user_input_ "${_SCRIPT}: " "0" || exit 0
	# 		_EXT="${_INPUT}"
	# 	}
	# 	if [ "${_EXT}" ]; then
	# 		[ "${_KEY_E}" ] || {
	# 			printf -- '%s\n' "${_SCRIPT}: you set extension -- '${_EXT}'" >&2
	# 			_user_input_ "${_SCRIPT}: continue? (Y/n): " "0" || {
	# 				unset "_EXT"; continue
	# 			}
	# 		}
	# 	else
	# 		printf -- '%s\n' "${_SCRIPT}: extension not set"
	# 		_user_input_ "${_SCRIPT}: continue? (Y/n): " "0" || {
	# 			unset "_EXT"; continue
	# 		}
	# 	fi
	# 	break
	# done
}

_exec_command_for_files_()
{
	set -- ${_COMMAND}
	if [ -d "${_SOURCE}" ]; then
		IFS=$'\n'
		for _FILE in `find "${_SOURCE}" -type f -name "${_EXT}"`; do
			_DES_FILE="${_OUTPUT}${_FILE#${_SOURCE}}"
			_DES_DIR="`dirname -- "${_DES_FILE}"`"
			if [ -e "${_DES_DIR}" ]; then
				[ -e "${_DES_FILE}" ] && {
					[ -f "${_DES_FILE}" ] && {
						[ "${_NO_ALL}" = "1" ] && continue
						[ "${_YES_ALL}" = "1" ] || [ "${_KEY_F}" ] || {
							printf -- '%s\n' "${_SCRIPT}: file exists: '${_DES_FILE}'"
							_user_input_ "${_SCRIPT}: overwrite? (y/N), overwrite all (a), skip all (s): " "1" || continue
						}
					}
				}
			else
				mkdir -p -- "${_DES_DIR}" || {
					printf -- '%s\n' "${_SCRIPT}: error: create -- '${_DES_DIR}'" >&2
					continue
				}
			fi
			_ERROR="${_COMMAND} ${_FILE} ${_DES_FILE}"
			${@} "${_FILE}" "${_DES_FILE}" || {
				printf -- '%s\n' "${_SCRIPT}: error: command execution error -- '${_ERROR}'" >&2
				[ "${_YES_ALL}" = "1" ] || [ "${_KEY_F}" ] || {
					_user_input_ "${_SCRIPT}: continue? (y/N), continue all (a): " "1" || return 80
				}
			}
			#sleep 1 # Для того, чтобы не ломанулось
		done
	elif [ -f "${_SOURCE}" ]; then
		[ "${_EXT}" ] && _OUTPUT="${_OUTPUT%.*}.${_EXT}"
		_ERROR="${_COMMAND} ${_SOURCE} ${_OUTPUT}"
		mkdir -p -- "`dirname -- "${_OUTPUT}"`"
		${@} "${_SOURCE}" "${_OUTPUT}" || return
	else
		return 30
	fi
}

_main_()
{
	_parsing_arguments_ "${@}" || {
		_COD_OUT="${?}"
		_usage_ "${_SCRIPT}"
		printf -- '%s\n' "Try '${_SCRIPT} --help' for more information."
		return "${_COD_OUT}"
	}
	[ "${_KEY_H}" ] && {
		_usage_ "${_SCRIPT}"
		_help_ "${_SCRIPT}"
		exit
	}
	_EXT="${_EXT:-*.[pP][dD][fF]}"
	_parse_arguments_ || return
	while :;do
		printf -- '%s\n' ""
		printf -- '%s\n' "${_SCRIPT}: check the assignment:"
		printf -- '%s\n' "SOURCE: '${_SOURCE}'" "OUTPUT: '${_OUTPUT}'" "EXTENSION: '${_EXT}'" "COMMAND: '${_COMMAND}'"
		_user_input_ "${_SCRIPT}: continue? (Y/n), 'q' for out: " "0" || {
			unset "_SOURCE" "_OUTPUT" "_EXT" "_COMMAND"
			_parse_arguments_ || continue
		}
		break
	done
	_exec_command_for_files_ || return
}

_main_ "${@}"
_COD_OUT="${?}"
[ "${_COD_OUT}" -ne 0 ] && {
	case "${_COD_OUT}" in
		20  ) printf -- '%s\n' "${_SCRIPT}: error: no arguments" >&2 ;;
		21  ) printf -- '%s\n' "${_SCRIPT}: error: number of arguments exceeded" >&2 ;;
		23  ) printf -- '%s\n' "${_SCRIPT}: error: invalid option -- '${_ERROR}'" >&2 ;;
		24  ) printf -- '%s\n' "${_SCRIPT}: error: option requires an argument -- '${_ERROR}'" >&2 ;;
		25  ) printf -- '%s\n' "${_SCRIPT}: error: option '${_OPT}' has an invalid argument -- '${_ERROR}'" >&2 ;;
		30  ) printf -- '%s\n' "${_SCRIPT}: error: no such file or directory -- '${_ERROR}'" >&2 ;;
		80  ) printf -- '%s\n' "${_SCRIPT}: error: command execution error -- '${_ERROR}'" >&2 ;;
		*   ) printf -- '%s\n' "${_SCRIPT}: error: unknown error" >&2 ;;
	esac
} || printf -- '%s\n' "${_SCRIPT}: succeeded" >&2
return "${_COD_OUT}" 2>/dev/null
exit "${_COD_OUT}"
