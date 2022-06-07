import { WebPlugin } from '@capacitor/core';
import { CapacitorHealthkitPlugin } from './definitions';

export class CapacitorHealthkit extends WebPlugin implements CapacitorHealthkitPlugin {

  async requestAuthorization(_options: any): Promise<any> {
    this.throwUnsupportedError();
  }
  async isAvailable(): Promise<any> {
    this.throwUnsupportedError();
  }
  async queryHKitSampleType(_options: any): Promise<any> {
    this.throwUnsupportedError();
  }

  async queryAggregatedDailySampleType(_options: any): Promise<any> {
    this.throwUnsupportedError();
  }

  async multipleQueryHKitSampleType(): Promise<any> {
    this.throwUnsupportedError();
  }
  async isEditionAuthorized(): Promise<any> {
    this.throwUnsupportedError();
  }
  async multipleIsEditionAuthorized(): Promise<any> {
    this.throwUnsupportedError();
  }

  private throwUnsupportedError(): never {
    throw this.unavailable(
      'CapacitorHealthkit not available in this browser.',
    );
  }

}