script_name('ARZ �������') -- �������� �������
script_author('Auditore') -- ����� �������
script_description('New Commands') -- �������� �������
--����������
require 'moonloader'
imgui = require 'imgui'
encoding = require 'encoding'
inicfg = require 'inicfg'
--�����
encoding.default = 'CP1251'
u8 = encoding.UTF8
------------------
-------������� �����
MENU = imgui.ImBool(false)
------------
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'

update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Audit-hub/-/master/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/Audit-hub/-/raw/master/ARZ_by_Audit.lua" -- ��� ���� ������
local script_path = thisScript().path


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				updateIni = inicfg.load(nil, update_path)
				if tonumber (updateIni.info.vers) > script_vers then
					sampAddChatMessage('���� ����������! ������: ' .. updateIni.info.vers_text, -1)
				update_state = true
				end	
				os.remove(update_path)
		end
	end)

	--����������� �������
	sampRegisterChatCommand("med", cmd_med)
	sampRegisterChatCommand("us", cmd_us)
	sampRegisterChatCommand("ar", cmd_ar)
	sampRegisterChatCommand("ms", cmd_ms)
	sampRegisterChatCommand("dm", cmd_dm)
	sampRegisterChatCommand("unv", cmd_unv)
	sampRegisterChatCommand("inv", cmd_inv)
	sampRegisterChatCommand("gr", cmd_gr)
	sampRegisterChatCommand('com', cmd_com)
	-----------
	--sampRegisterChatCommand('dev', cmd_dev)
	-----------��� ������� ������� ����� ���������:
	sampAddChatMessage('������ {FFFF00} ����������� �������', -1)
	sampAddChatMessage('������� {00FF00} ��������', -1)
	sampAddChatMessage('�����: {FFFF00} Takashi Auditore', -1)
	sampAddChatMessage('C��������� ���: {FFFF00} Santo Anderson', -1)
 
	while true do
		imgui.Process = MENU.v

		if isKeyDown(VK_K) then
			MENU.v = true -- ��������� ���� Imgui
		end
	wait(0)
	end
 end

 function cmd_med(arg)
	sampSendChat('/usemed')
 end

 function cmd_us(arg)
	sampSendChat('/usedrugs ' .. arg)
 end

 function cmd_ar(arg)
	sampSendChat('/armour')
 end

 function cmd_ms(arg)
 	sampSendChat('/mask')
 end

 function cmd_dm(arg)
	 sampSendChat('/mask')
	 sampSendChat('/armour')
 end

 function cmd_com(arg)
	MENU.v = not MENU.v -- �������������
	--imgui.Process = MENU.v
 end

 function cmd_unv(arg)
	var1, var2 = string.match(arg, '(.+) (.+)')
	if var1 == nill or var1 == '' then
		sampAddChatMessage('�������: {00FF00}/unv id �������', -1)
	else
	sampSendChat('/uninvite ' .. var1 .. ' ' .. var2)
	end
 end

 function cmd_inv(arg)
	sampSendChat('/invite ' .. arg)
 end

 function cmd_gr(arg)
	var1, var2 = string.match(arg, '(.+) (.+)')
	if var1 == nill or var1 == '' then
		sampAddChatMessage('�������: {00FF00}/gr id ����', -1)
	else
	sampSendChat('/giverank ' .. var1 .. ' ' .. var2)
	end

	if update_state then
		downloadUrlToFile(script_url, script_vers, script_path, function(id, status)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				sampAddChatMessage('������ ������� ��������!', -1)
				thisScript():reload()
			end

		end)
	end

 end

 --function cmd_dev
	--sampAddChatMessage('�����������! {00FF00} �� ������� ����� � �����-������������!',-1)
-- end

 function imgui.OnDrawFrame()
    local sw, sh = getScreenResolution() -- ��������� ���������� ������
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- ������������ ���� �� ������
    imgui.SetNextWindowSize(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver) -- ������ ����
	-- P.S imgui.Cond.FirstUseEver - �������� ��������� �������� ������ ���� ��� - ��� ������ ������ ����
	imgui.Begin(u8'���� ������', MENU, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) -- _, = �������� ������
			if imgui.Button(u8'������� �������', imgui.ImVec2(-1, 20)) then
				sampSendChat('/usemed')
			end
			--MENU.v = false
				if imgui.Button(u8'������� �����', imgui.ImVec2(-1, 20)) then
					sampSendChat('/armour')
				end
				--MENU.v = false
					if imgui.Button(u8'������� ����� � �����', imgui.ImVec2(-1, 20)) then
					lua_thread.create(function()
						sampSendChat('/armour')
							wait(5000)
							sampSendChat('/mask')
						end)
					end
					--MENU.v = false
						if imgui.Button(u8'������� �����(3 �����)', imgui.ImVec2(-1, 20)) then
							sampSendChat('/usedrugs 3')
						end
						--MENU.v = false
							if imgui.Button(u8'������� �����(2 �����)', imgui.ImVec2(-1, 20)) then
								sampSendChat('/usedrugs 2')
							end
							--MENU.v = false
								if imgui.Button(u8'������� �����(1 �����)', imgui.ImVec2(-1, 20)) then
									sampSendChat('/usedrugs 3')
								end
								--MENU.v = false
								if imgui.Button(u8'��������', imgui.ImVec2(-1, 20)) then
									imgui.OpenPopup(u8'��� �������� �������')
								end
						
								if imgui.BeginPopupModal(u8'��� �������� �������', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize) then
									imgui.Separator()	
									if imgui.Button(u8'������� �������� � ���', imgui.ImVec2(200, 20)) then
											sampAddChatMessage('===========[�������]===========', -1)
											sampAddChatMessage('/usemed - /med',-1)
											sampAddChatMessage('/usedrugs - /us',-1)
											sampAddChatMessage('/armour - /ar',-1)
											sampAddChatMessage('/mask - /ms',-1)
											sampAddChatMessage('/dm - ����� � �����',-1)
											sampAddChatMessage('/uninvite - /unv',-1)
											sampAddChatMessage('/invite - /inv',-1)
											sampAddChatMessage('/giverank - /gr',-1)
											sampAddChatMessage('/com - ��������� �������',-1)
											sampAddChatMessage('===============================', -1)
										end
										imgui.Separator()
										if imgui.Button(u8'�������', imgui.ImVec2(200, 20)) then 
									imgui.CloseCurrentPopup()
								end
									imgui.EndPopup()
								end
						
									imgui.End()
end
-----test obnovi gi gi gi