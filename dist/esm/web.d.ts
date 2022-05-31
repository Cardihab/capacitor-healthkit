import { WebPlugin } from '@capacitor/core';
import { CapacitorHealthkitPlugin } from './definitions';
export declare class CapacitorHealthkitWeb extends WebPlugin implements CapacitorHealthkitPlugin {
    constructor();
    requestAuthorization(_options: any): Promise<any>;
    isAvailable(): Promise<any>;
    queryHKitSampleType(_options: any): Promise<any>;
    queryAggregatedDailySampleType(_options: any): Promise<any>;
    multipleQueryHKitSampleType(): Promise<any>;
    isEditionAuthorized(): Promise<any>;
    multipleIsEditionAuthorized(): Promise<any>;
}
declare const CapacitorHealthkit: CapacitorHealthkitWeb;
export { CapacitorHealthkit };
