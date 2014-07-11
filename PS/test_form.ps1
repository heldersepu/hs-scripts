# Load assemblies for forms
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

#region _Custom_Functions_
	function Disable-Proxy {
        Write-Host "Disable-Proxy"
		# Push-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings";
		# set-itemproperty . ProxyEnable 0;
		# Pop-Location;
	}

	function Enable-Proxy {
        Write-Host "Enable-Proxy"
		# Push-Location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings";
		# set-itemproperty . ProxyEnable 1;
		# Pop-Location;
	}
	
	function Get-ProxyState {
		return (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings").ProxyEnable;
	}
    
    function OKButton_Click {
        switch ($objComboBox.SelectedItem)
    	{
    		"Enabled" {Enable-Proxy}
    		"Disabled" {Disable-Proxy}
    	}
    	$objForm.Close()
    }
    
    function objForm_KeyDown {
        if ($_.KeyCode -eq "Enter") 
        {
            $x=$objTextBox.Text;
            $objForm.Close()
        }
        elseif ($_.KeyCode -eq "Escape") 
        {
            $objForm.Close()
        }
    }
#endregion _Custom_Functions_

# Add form
$objForm = New-Object System.Windows.Forms.Form;
$objForm.ShowIcon = $false;
$objForm.Text = "Enable Internet Proxy"
$objForm.Size = New-Object System.Drawing.Size(300,170) 
$objForm.StartPosition = "CenterScreen"
$objForm.MinimizeBox = $false;
$objForm.MaximizeBox = $false;
$objForm.KeyPreview = $True
$objForm.Add_KeyDown({objForm_KeyDown})

# Add label instructing to select an option
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,30) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.Text = "Set the proxy state."
$objForm.Controls.Add($objLabel) 

# Add combobox for selection
$objComboBox = New-Object System.Windows.Forms.ComboBox;
$ComboBoxOptions = "Disabled", "Enabled";
$objComboBox.Items.AddRange($ComboBoxOptions);
$objComboBox.SelectedIndex = 0;
$objComboBox.Location = New-Object System.Drawing.Size(10,50) 
$objComboBox.Size = New-Object System.Drawing.Size(260,20) 
$objForm.Controls.Add($objComboBox)

#region _Form_Buttons_
    # Add Ok button
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Size(50,90)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = "OK"
    $OKButton.Add_Click({OKButton_Click})
    $objForm.Controls.Add($OKButton)

    # Add cancel button
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size(150,90)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = "Cancel"
    $CancelButton.Add_Click({$objForm.Close()})
    $objForm.Controls.Add($CancelButton)
#endregion _Form_Buttons_

$objForm.Topmost = $True
[void] $objForm.ShowDialog()