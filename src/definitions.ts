/*
declare module "@capacitor/core" {
  interface PluginRegistry {
    CapacitorHealthkit: CapacitorHealthkitPlugin;
  }
}
*/
declare global {
  interface PluginRegistry {
    CapacitorHealthkit?: CapacitorHealthkitPlugin;
  }
}

export interface CapacitorHealthkitPlugin {
  requestAuthorization(): Promise<any>;
  isAvailable(): Promise<any>;
  queryHKitSampleType(options: any): Promise<any>;
  queryAggregatedDailySampleType(options: any): Promise<any>;
  multipleQueryHKitSampleType(): Promise<any>;
  isEditionAuthorized(): Promise<any>;
  multipleIsEditionAuthorized(): Promise<any>;
}