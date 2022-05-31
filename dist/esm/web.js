import { WebPlugin } from '@capacitor/core';
export class CapacitorHealthkitWeb extends WebPlugin {
    constructor() {
        super({
            name: 'CapacitorHealthkit',
            platforms: ['web']
        });
    }
    async requestAuthorization() {
        throw new Error("Method not implemented.");
    }
    async isAvailable() {
        throw new Error("Method not implemented.");
    }
    async queryHKitSampleType(_options) {
        throw new Error("Method not implemented.");
    }
    async queryAggregatedDailySampleType(_options) {
        throw new Error("Method not implemented.");
    }
    async multipleQueryHKitSampleType() {
        throw new Error("Method not implemented.");
    }
    async isEditionAuthorized() {
        throw new Error("Method not implemented.");
    }
    async multipleIsEditionAuthorized() {
        throw new Error("Method not implemented.");
    }
}
const CapacitorHealthkit = new CapacitorHealthkitWeb();
export { CapacitorHealthkit };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(CapacitorHealthkit);
//# sourceMappingURL=web.js.map