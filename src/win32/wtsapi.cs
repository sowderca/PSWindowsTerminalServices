using System;
using System.Runtime.InteropServices;

public enum WTS_CONNECTSTATE_CLASS {
    WTSActive,
    WTSConnected,
    WTSConnectQuery,
    WTSShadow,
    WTSDisconnected,
    WTSIdle,
    WTSListen,
    WTSReset,
    WTSDown,
    WTSInit
}

[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
public struct WTSINFOEX_LEVEL1_W {
    public Int32 SessionId;

    public WTS_CONNECTSTATE_CLASS SessionState;

    // 0 = locked, 1 = unlocked , ffffffff = unknown
    public Int32 SessionFlags;

    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 33)]
    public string WinStationName;

    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
    public string UserName;

    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 18)]
    public string DomainName;

    public UInt64 LogonTime;

    public UInt64 ConnectTime;

    public UInt64 DisconnectTime;

    public UInt64 LastInputTime;

    public UInt64 CurrentTime;

    public Int32 IncomingBytes;

    public Int32 OutgoingBytes;

    public Int32 IncomingFrames;

    public Int32 OutgoingFrames;

    public Int32 IncomingCompressedBytes;

    public Int32 OutgoingCompressedBytes;
}

[StructLayout(LayoutKind.Sequential)]
public struct WTS_SESSION_INFO {
    public Int32 SessionID;

    [MarshalAs(UnmanagedType.LPStr)]
    public String pWinStationName;

    public WTS_CONNECTSTATE_CLASS State;
}

// Union
[StructLayout(LayoutKind.Explicit)]
public struct WTSINFOEX_LEVEL_W {
    [FieldOffset(0)]
    public WTSINFOEX_LEVEL1_W WTSInfoExLevel1;
}

[StructLayout(LayoutKind.Sequential)]
public struct WTSINFOEX {
    public Int32 Level;

    public WTSINFOEX_LEVEL_W Data;
}

public enum WTS_INFO_CLASS {
    WTSInitialProgram,

    WTSApplicationName,

    WTSWorkingDirectory,

    WTSOEMId,

    WTSSessionId,

    WTSUserName,

    WTSWinStationName,

    WTSDomainName,

    WTSConnectState,

    WTSClientBuildNumber,

    WTSClientName,

    WTSClientDirectory,

    WTSClientProductId,

    WTSClientHardwareId,

    WTSClientAddress,

    WTSClientDisplay,

    WTSClientProtocolType,

    WTSIdleTime,

    WTSLogonTime,

    WTSIncomingBytes,

    WTSOutgoingBytes,

    WTSIncomingFrames,

    WTSOutgoingFrames,

    WTSClientInfo,

    WTSSessionInfo,

    WTSSessionInfoEx,

    WTSConfigInfo,

    // Info Class value used to fetch Validation Information through the WTSQuerySessionInformation
    WTSValidationInfo,

    WTSSessionAddressV4,

    WTSIsRemoteSession
}
public static class wtsapi {
    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern int WTSQuerySessionInformationW(IntPtr hServer, int SessionId, int WTSInfoClass, ref System.IntPtr ppSessionInfo, ref int pBytesReturned);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern int WTSEnumerateSessions(IntPtr hServer, int Reserved, int Version, ref IntPtr ppSessionInfo, ref int pCount);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern IntPtr WTSOpenServer(string pServerName);
    
    [DllImport("wtsapi32.dll", SetLastError = true)]
    static extern bool WTSDisconnectSession(IntPtr hServer, int sessionId, bool bWait);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern void WTSCloseServer(IntPtr hServer);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern void WTSFreeMemory(IntPtr pMemory);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    static extern bool WTSLogoffSession(IntPtr hServer, int SessionId, bool bWait);

    [DllImport("wtsapi32.dll", SetLastError = true)]
    public static extern bool WTSSendMessage(
        IntPtr hServer,
        [MarshalAs(UnmanagedType.I4)] int SessionId,
        string pTitle,
        [MarshalAs(UnmanagedType.U4)] int TitleLength,
        string pMessage,
        [MarshalAs(UnmanagedType.U4)] int MessageLength,
        [MarshalAs(UnmanagedType.U4)] int Style,
        [MarshalAs(UnmanagedType.U4)] int Timeout,
        [MarshalAs(UnmanagedType.U4)] out int pResponse,
        bool bWait
    );
}