$(function () {
    $("#print").click(function () {
        /*if (!!window.ActiveXObject || "ActiveXObject" in window) {
            remove_ie_header_and_footer();
        }*/
        $("#body").printArea();
    })
})

function remove_ie_header_and_footer() {
    var hkey_root, hkey_path, hkey_key;
    hkey_path = "HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
    try {
        var RegWsh = new ActiveXObject("WScript.Shell");
        RegWsh.RegWrite(hkey_path + "header", "");
        RegWsh.RegWrite(hkey_path + "footer", "");
    } catch (e) {
    }
}