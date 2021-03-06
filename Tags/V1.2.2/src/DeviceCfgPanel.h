#ifndef DEVICECFGPANEL_H
#define DEVICECFGPANEL_H

//(*Headers(TDeviceCfgPanel)
#include <wx/sizer.h>
#include <wx/stattext.h>
#include <wx/textctrl.h>
#include <wx/checkbox.h>
#include <wx/panel.h>
#include <wx/grid.h>
#include <wx/choice.h>
//*)

#include <WinPicPr/Devices.h>

class TDeviceCfgPanel: public wxPanel
{
	public:

		TDeviceCfgPanel(wxWindow* parent,wxWindowID id,const wxPoint& pos,const wxSize& size, long style, const wxString& name);
		virtual ~TDeviceCfgPanel();

		//(*Declarations(TDeviceCfgPanel)
		wxStaticText* StaticText9;
		wxChoice* aPartNameChoice;
		wxTextCtrl* aConfigWordHexEdit2;
		wxTextCtrl* aConfigWordHexEdit;
		wxStaticText* StaticText6;
		wxStaticText* StaticText8;
		wxStaticText* StaticText3;
		wxTextCtrl* aProgMemSizeText;
		wxCheckBox* aHasFlashMemoryChk;
		wxStaticText* aSavedBeforeEraseText;
		wxStaticText* StaticText5;
		wxStaticText* StaticText7;
		wxTextCtrl* aEepromMemSizeText;
		wxStaticText* aSavedBeforeEraseTitle;
		wxStaticText* StaticText4;
		wxGrid* aDevCfgGrid;
		//*)

        unsigned short      m_displayed_config_word[2];  // TWO cfg words since 2003-12 !!
        char                m_sz40DisplayedDeviceName[44];
        T_PicConfigBitInfo *m_pConfigBitGridRowNumber_to_ConfigBitInfoPtr[PICDEV_MAX_CONFIG_BIT_INFOS];

        void UpdateDeviceConfigTab(bool fUpdateHexWord);
        void UpdateConfigBitGrid(void);
        void ApplyConfigBitGrid(void);

        static void SetDevice(const char *pDeviceName);

	protected:

		//(*Identifiers(TDeviceCfgPanel)
		static const long ID_STATICTEXT3;
		static const long ID_PART_NAME_CHOICE;
		static const long ID_STATICTEXT4;
		static const long ID_TEXTCTRL5;
		static const long ID_STATICTEXT5;
		static const long ID_STATICTEXT6;
		static const long ID_TEXTCTRL6;
		static const long ID_STATICTEXT7;
		static const long ID_TEXTCTRL7;
		static const long ID_STATICTEXT8;
		static const long ID_TEXTCTRL8;
		static const long ID_STATICTEXT9;
		static const long ID_CHECKBOX13;
		static const long ID_STATICTEXT21;
		static const long ID_SAVED_BEFORE_ERASE_TEXT;
		static const long ID_DEV_CFG_GRID;
		//*)

	private:

		//(*Handlers(TDeviceCfgPanel)
		void onPartNameChoiceSelect(wxCommandEvent& event);
		void onConfigWordHexEditText(wxCommandEvent& event);
		void onConfigWordHexEdit2Text(wxCommandEvent& event);
		void onProgMemSizeTextText(wxCommandEvent& event);
		void onEepromMemSizeTextText(wxCommandEvent& event);
		void onHasFlashMemoryChkClick(wxCommandEvent& event);
		void onDevCfgGridCellChange(wxGridEvent& event);
		//*)

		DECLARE_EVENT_TABLE()
};

#endif
