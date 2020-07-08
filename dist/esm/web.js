import { WebPlugin } from '@capacitor/core';
export class CapacitorHealthkit extends WebPlugin {
    async requestAuthorization(_options) {
        this.throwUnsupportedError();
    }
    async isAvailable() {
        this.throwUnsupportedError();
    }
    async queryHKitSampleType(_options) {
        this.throwUnsupportedError();
    }
    async queryAggregatedDailySampleType(_options) {
        this.throwUnsupportedError();
    }
    async multipleQueryHKitSampleType() {
        this.throwUnsupportedError();
    }
    async isEditionAuthorized() {
        this.throwUnsupportedError();
    }
    async multipleIsEditionAuthorized() {
        this.throwUnsupportedError();
    }
    throwUnsupportedError() {
        throw this.unavailable('CapacitorHealthkit not available in this browser.');
    }
}
//# sourceMappingURL=web.js.map